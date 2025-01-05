CREATE TABLE TICKETS (
    TICKET_ID NUMBER PRIMARY KEY,
    DNI VARCHAR2(9) NOT NULL,
    PRICE NUMBER(5,2) NOT NULL,
    DATESTARTVALIDITY DATE NOT NULL,
    DATEENDVALIDITY DATE NOT NULL
);

CREATE TABLE ACCOUNTS (
    ACCOUNTID NUMBER PRIMARY KEY,
    EMAIL VARCHAR2(50) NOT NULL,
    USERNAME VARCHAR2(50) NOT NULL,
    BIRTHDATE DATE NOT NULL,
    LANGUAGE NVARCHAR2(20) NOT NULL
);

CREATE TABLE DISCOUNTS (
    DISCOUNTID NUMBER PRIMARY KEY,
    DISCOUNTNAME VARCHAR2(20) NOT NULL,
    PERCENTAGE NUMBER NOT NULL
);

CREATE TABLE CONTRACTS (
    CONTRACTID NUMBER PRIMARY KEY,
    STARTDATE DATE NOT NULL,
    FINISHDATE DATE NOT NULL,
    BASESALARY NUMBER(6,2) NOT NULL,
    EXTRA_PERCENT NUMBER NOT NULL,
    HOURS NUMBER NOT NULL,
    BANKACCOUNT VARCHAR2(20) NOT NULL
);

CREATE TABLE SECTIONS (
    SectionID NUMBER PRIMARY KEY,
    SectionName VARCHAR2(100) NOT NULL,
    Dimension NUMBER NOT NULL,
    Visitors NUMBER
);

CREATE TABLE PRODUCTS (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(100) NOT NULL,
    Price NUMBER(6,2) NOT NULL,
    ExpirationDate DATE
);

CREATE TABLE EMERGENCYCONTACTS (
    DNI VARCHAR2(9) PRIMARY KEY,
    PhoneNumber NUMBER NOT NULL,
    FullName NVARCHAR2(100) NOT NULL
);

CREATE TABLE ANIMALS (
    AnimalID NUMBER PRIMARY KEY,
    Species VARCHAR2(100) NOT NULL,
    Sex VARCHAR2(20) NOT NULL,
    Weight NUMBER NOT NULL,
    Birthdate DATE NOT NULL,
    TimeAtTheZoo NUMBER NOT NULL,
    MorningFood VARCHAR2(100) NOT NULL,
    NightFood VARCHAR2(100) NOT NULL,
    Medicine VARCHAR2(100) NOT NULL,
    DateOfArrival DATE NOT NULL
);

CREATE TABLE VIPPASSES (
    TICKET_ID NUMBER PRIMARY KEY NOT NULL,
    FOREIGN KEY (TICKET_ID) REFERENCES TICKETS(TICKET_ID)
);

CREATE TABLE PAYMENTMETHODS (
    ACCOUNTID NUMBER PRIMARY KEY NOT NULL,
    PAYMENTMETHOD VARCHAR2(20) NOT NULL,
    FOREIGN KEY (ACCOUNTID) REFERENCES ACCOUNTS(ACCOUNTID)
);

CREATE TABLE DAYS (
    CONTRACTID NUMBER PRIMARY KEY NOT NULL,
    DAYS VARCHAR2(20) NOT NULL,
    FOREIGN KEY (CONTRACTID) REFERENCES CONTRACTS(CONTRACTID)
);

CREATE TABLE SHOPS (
    ShopID NUMBER PRIMARY KEY,
    ShopName VARCHAR2(100) NOT NULL,
    SectionID NUMBER,
    CONSTRAINT ShopSection FOREIGN KEY (SectionID) REFERENCES SECTIONS(SectionID)
);

CREATE TABLE ENCLOSURES (
    EnclosureID CHAR(5) PRIMARY KEY,
    Species VARCHAR2(200),
    EnclosureFloorMaterial NUMBER NOT NULL,
    DateLastInspection DATE,
    DateNextInspection DATE NOT NULL,
    SectionID NUMBER,
    CONSTRAINT EnclosureSection FOREIGN KEY (SectionID) REFERENCES SECTIONS(SectionID)
);

CREATE TABLE EMPLOYEE (
    EmployeeID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    DNI VARCHAR2(9) NOT NULL,
    Name VARCHAR2(100) NOT NULL,
    Surname VARCHAR2(100) NOT NULL,
    Gender VARCHAR2(20) NOT NULL,
    DateFirstContract DATE NOT NULL,
    Email VARCHAR2(50) NOT NULL,
    TelefoneNumber NUMBER NOT NULL,
    StreeOrAvenue VARCHAR2(100) NOT NULL,
    Location VARCHAR2(100) NOT NULL,
    ContactDNI VARCHAR2(9) NOT NULL,
    CONSTRAINT fk_ConEm FOREIGN KEY (ContactDNI) REFERENCES EMERGENCYCONTACTS(DNI)
);

CREATE TABLE PARENTS (
    AnimalID NUMBER PRIMARY KEY,
    ParentID NUMBER,
    CONSTRAINT fk_Parents1 FOREIGN KEY (AnimalID) REFERENCES ANIMALS(AnimalID),
    CONSTRAINT fk_Parents2 FOREIGN KEY (ParentID) REFERENCES ANIMALS(AnimalID)
);

CREATE TABLE ILLNESSES (
    AnimalId NUMBER PRIMARY KEY,
    Illnesses VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_Illnesses FOREIGN KEY (AnimalId) REFERENCES ANIMALS(AnimalID)
);

CREATE TABLE ROUTES (
    RouteID NUMBER PRIMARY KEY,
    RouteName VARCHAR2(100) NOT NULL,
    EstimatedLengthTime NUMBER NOT NULL,
    StartHour DATE NOT NULL,
    SectionID NUMBER,
    CONSTRAINT fk_RoutesSec FOREIGN KEY (SectionID) REFERENCES SECTIONS(SectionID)
);

CREATE TABLE ENCLOSUREITEMS (
    EnclosureitemID NUMBER PRIMARY KEY,
    Nombre VARCHAR2(100) NOT NULL,
    EnclosureID CHAR(5),
    CONSTRAINT EnclosureEnclosureItem FOREIGN KEY (EnclosureID) REFERENCES ENCLOSURES(EnclosureID)
);

CREATE TABLE SHOPRO (
    ShopID NUMBER,
    ProductID NUMBER,
    PRIMARY KEY (ShopID, ProductID),
    CONSTRAINT fk_shop FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID),
    CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID)
);

CREATE TABLE LANGUAGES (
    EmployeeId NUMBER PRIMARY KEY,
    Languages VARCHAR2(20) NOT NULL
);

CREATE TABLE SECURITYEMPLOYEES (
    EmployeeID NUMBER PRIMARY KEY,
    Shift VARCHAR2(20) NOT NULL,
    ExtraHoures NUMBER NOT NULL,
    CONSTRAINT fk_SecEmp FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEES(EmployeeID)
);

CREATE TABLE STRUCTURALEMPLOYEES (
    EmployeeID NUMBER PRIMARY KEY,
    Shift VARCHAR2(20) NOT NULL,
    ExtraHoures NUMBER NOT NULL,
    CONSTRAINT fk_StrEmp FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEES(EmployeeID)
);

CREATE TABLE ANIMALEMPLOYEES (
    EmployeeID NUMBER PRIMARY KEY,
    CONSTRAINT fk_AniEmp FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEES(EmployeeID)
);  

-- 4. Siguiente nivel de dependencias
CREATE TABLE GUARD (
    EmployeeID NUMBER PRIMARY KEY,
    Rank VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_Guard FOREIGN KEY (EmployeeID) REFERENCES SecurityEmployees(EmployeeID)
);

CREATE TABLE ACCTIC (
    TICKET_ID NUMBER NOT NULL,
    ACCOUNTID NUMBER NOT NULL,
    FOREIGN KEY (TICKET_ID) REFERENCES TICKETS(TICKET_ID),
    FOREIGN KEY (ACCOUNTID) REFERENCES ACCOUNTS(ACCOUNTID),
    PRIMARY KEY (TICKET_ID, ACCOUNTID)
);

CREATE TABLE SHOPROSEC (
    ShopID NUMBER,
    ProductID NUMBER,
    SectionID NUMBER,
    PRIMARY KEY (ShopID, ProductID, SectionID),
    CONSTRAINT fk_shopro FOREIGN KEY (ShopID, ProductID) REFERENCES SHOPRO(ShopID, ProductID),
    CONSTRAINT fk_section FOREIGN KEY (SectionID) REFERENCES SECTIONS(SectionID)
);

CREATE TABLE ENCANI (
    EnclosureID CHAR(5) PRIMARY KEY,
    Species NVARCHAR(100) NOT NULL,
    Population NUMBER NOT NULL,
    AnimalID NUMBER,
    CONSTRAINT fk_EncAniEnc FOREIGN KEY (EnclosureID) REFERENCES ENCLOSURES(EnclosureID),
    CONSTRAINT fk_EncAniAni FOREIGN KEY (AnimalID) REFERENCES ANIMALS(AnimalID)
);

CREATE TABLE SURVEILLANCE (
    EmployeeID NUMBER PRIMARY KEY,
    CONSTRAINT fk_Surveillance FOREIGN KEY (EmployeeID) REFERENCES GUARD(EmployeeID)
);

CREATE TABLE CLEANER (
    EmployeeID NUMBER PRIMARY KEY,
    CONSTRAINT fk_Cleaners FOREIGN KEY (EmployeeID) REFERENCES STRUCTURALEMPLOYEES(EmployeeID)
);

CREATE TABLE SHOPKEEPERS (
    EmployeeID NUMBER PRIMARY KEY,
    ShopID NUMBER,
    CONSTRAINT fk_ShopKeepers FOREIGN KEY (EmployeeID) REFERENCES STRUCTURALEMPLOYEES(EmployeeID),
    CONSTRAINT fk_ShopShopKeepers FOREIGN KEY (ShopID) REFERENCES SHOPS(ShopID)
);

CREATE TABLE TICKETSELLERS (
    EmployeeID NUMBER PRIMARY KEY,
    CONSTRAINT fk_TicketSellers FOREIGN KEY (EmployeeID) REFERENCES STRUCTURALEMPLOYEES(EmployeeID)
);

CREATE TABLE INSPECTORS (
    EmployeeID NUMBER PRIMARY KEY,
    CONSTRAINT fk_Inspectors FOREIGN KEY (EmployeeID) REFERENCES STRUCTURALEMPLOYEES(EmployeeID)
);

CREATE TABLE CARETAKER (
    EmployeeID NUMBER PRIMARY KEY,
    CONSTRAINT fk_CareTaker FOREIGN KEY (EmployeeID) REFERENCES ANIMALEMPLOYEES(EmployeeID)
);

CREATE TABLE VETERINARIES (
    EmployeeID NUMBER PRIMARY KEY,
    CONSTRAINT fk_Veterinaries FOREIGN KEY (EmployeeID) REFERENCES ANIMALEMPLOYEES(EmployeeID)
);

CREATE TABLE GUIDEDENTRIES (
    TICKET_ID NUMBER NOT NULL,
    ROUTES_ID NUMBER,
    FOREIGN KEY (TICKET_ID) REFERENCES TICKETS(TICKET_ID),
    FOREIGN KEY (ROUTES_ID) REFERENCES ROUTES(RouteID),
    PRIMARY KEY (TICKET_ID, ROUTES_ID)
);

CREATE TABLE EMPCON (
    EMPLOYEEID NUMBER NOT NULL,
    CONTRACTID NUMBER NOT NULL,
    BONUSPAY NUMBER(6,2) NOT NULL,
    EXTRAHOURSPAY NUMBER NOT NULL,
    CONSTRAINT fk_EmpConEmp FOREIGN KEY (EMPLOYEEID) REFERENCES EMPLOYEES(EMPLOYEEID),
    CONSTRAINT fk_EmpConCon FOREIGN KEY (CONTRACTID) REFERENCES CONTRACTS(CONTRACTID),
    PRIMARY KEY (EMPLOYEEID, CONTRACTID)
);

CREATE TABLE SECGUA (
    EmployeeID NUMBER,
    SectionID NUMBER,
    AccidentDate DATE NOT NULL,
    AccidentCost NUMBER NOT NULL,
    CONSTRAINT fk_SecGuaEmp FOREIGN KEY (EmployeeID) REFERENCES SECURITYEMPLOYEES(EmployeeID),
    CONSTRAINT fk_SecGuaSec FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
    PRIMARY KEY (EmployeeID, SectionID)
);

CREATE TABLE WEAPONLICENCES (
    EmployeeID NUMBER PRIMARY KEY,
    WeaponLicencesID NUMBER,
    WeaponName VARCHAR2(20) NOT NULL,
    ExpirationDate DATE NOT NULL
);

CREATE TABLE WEAPON (
    WeaponLicencesID NUMBER PRIMARY KEY,
    WeaponID NUMBER,
    CONSTRAINT fk_WeaponLicences FOREIGN KEY (WeaponLicencesID) REFERENCES WEAPONLICENCES(WeaponLicencesID)
);

CREATE TABLE SECSUR (
    EmployeeID NUMBER,
    SectionID NUMBER,
    AccidentDate DATE NOT NULL,
    AccidentCost NUMBER NOT NULL,
    CONSTRAINT fk_SecSurEmp FOREIGN KEY (EmployeeID) REFERENCES SECURITYEMPLOYEES(EmployeeID),
    CONSTRAINT fk_SecSurSec FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
    PRIMARY KEY (EmployeeID, SectionID)
);

CREATE TABLE SECCLEA (
    EmployeeID NUMBER,
    SectionID NUMBER,
    AccidentDate DATE NOT NULL,
    AccidentCost NUMBER NOT NULL,
    CONSTRAINT fk_SecCleEmp FOREIGN KEY (EmployeeID) REFERENCES SECURITYEMPLOYEES(EmployeeID),
    CONSTRAINT fk_SecCleSec FOREIGN KEY (SectionID) REFERENCES SECTION(SectionID),
    PRIMARY KEY (EmployeeID, SectionID)
);

CREATE TABLE ANIVET (
    InterventionID NUMBER PRIMARY KEY,
    AnimalID NUMBER,
    EmployeeID NUMBER,
    CostOfTreatment NUMBER NOT NULL,
    CONSTRAINT fk_AniVetEmp FOREIGN KEY (EmployeeID) REFERENCES VETERINARIES(EmployeeID),
    CONSTRAINT fk_AniVetAni FOREIGN KEY (AnimalID) REFERENCES ANIMALS(AnimalID)
);

CREATE TABLE STUDIES (
    EmployeeID NUMBER PRIMARY KEY,
    Studies VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_Studies FOREIGN KEY (EmployeeID) REFERENCES VETERINARIES(EmployeeID),
);

CREATE TABLE GUIROU (
    RouteID NUMBER,
    EmployeeID NUMBER,
    CONSTRAINT fk_GuiRouEmp FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEES(EmployeeID),
    CONSTRAINT fk_GuiRouRou FOREIGN KEY (RouteID) REFERENCES ROUTES(RouteID),
    PRIMARY KEY (RouteID, EmployeeID)
);

CREATE TABLE ENCINS (
    EnclosureID CHAR(5),
    EmployeeID NUMBER,
    DateNextInspection DATE NOT NULL,
    DateLastInspection DATE NOT NULL,
    CONSTRAINT fk_EncInsEmp FOREIGN KEY (EmployeeID) REFERENCES INSPECTORS(EmployeeID),
    CONSTRAINT fk_EncInsEnc FOREIGN KEY (EnclosureID) REFERENCES ENCLOSURES(EnclosureID),
    PRIMARY KEY (EnclosureID, EmployeeID)
);

CREATE TABLE ENCCAR (
    EnclosureID CHAR(5),
    EmployeeID NUMBER,
    CONSTRAINT fk_EncCarEmp FOREIGN KEY (EmployeeID) REFERENCES CARETAKERS(EmployeeID),
    CONSTRAINT fk_EncCarEnc FOREIGN KEY (EnclosureID) REFERENCES ENCLOSURES(EnclosureID),
    PRIMARY KEY (EnclosureID, EmployeeID)
);

CREATE TABLE SPECIES (
    EnclosureID CHAR(5) PRIMARY KEY,
    Species VARCHAR2(100) NOT NULL,
    CONSTRAINT fk_SpeciesEnc FOREIGN KEY (EnclosureID) REFERENCES ENCLOSURES(EnclosureID)
);