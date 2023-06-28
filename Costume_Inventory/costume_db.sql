-- Initial Database creation of the backend database for a full stack inventory management application.

CREATE TABLE users (
    id INTEGER Primary KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    admin_status BOOLEAN NOT NULL,
    date_added DATE NOT NULL  
);

CREATE TABLE location (
    id INTEGER Primary KEY AUTOINCREMENT NOT NULL,
    floor_num INTEGER,
    room_num INTEGER,
    handicap_accesible BOOLEAN
);

CREATE TABLE shelf (
    id INTEGER Primary KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    location_id INTEGER NOT NULL,
    
    FOREIGN KEY (location_id) REFERENCES location(id)
);

CREATE TABLE shows (
    id INTEGER Primary KEY AUTOINCREMENT NOT NULL,
    period TEXT NOT NULL
);

CREATE Table time_periods (
  id INTEGER Primary KEY AUTOINCREMENT NOT NULL,
  period TEXT
);

CREATE TABLE renters (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    renter_name TEXT,
    renter_phone TEXT,
    renter_email TEXT
);

CREATE TABLE rentals (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    item_id INTEGER,
    renter_id INTEGER,
    date_rented DATE,
    return_date DATE,
    contact_number TEXT,
    clerk_id INTEGER,
    
    FOREIGN KEY (item_id) REFERENCES items(id)
    
);

CREATE TABLE items (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    item_name TEXT NOT NULL,
    item_location INTEGER NOT NULL,
    item_shelf INTEGER NOT NULL,
    item_show INTEGER NOT NULL,
    item_period TEXT,
    item_type TEXT,
    item_rented BOOLEAN,
    item_rented_info INTEGER NOT NULL,
    item_describe TEXT,
    item_photo TEXT,
    item_log_date DATE,
    item_user_modify INTEGER NOT NULL,
    
    FOREIGN KEY (item_location) REFERENCES location(location_id),
    FOREIGN KEY (item_show) REFERENCES shows(show_id),
    FOREIGN KEY (item_user_modify) REFERENCES users(user_id),
    FOREIGN KEY (item_shelf) REFERENCES shelf(id),
    FOREIGN KEY (item_period) REFERENCES time_period(id),
    FOREIGN KEY (item_rented_info) REFERENCES rentals(id)
);

CREATE TABLE item_attributes (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    item_color TEXT,
    item_print TEXT,
    item_fabric TEXT,
    item_size TEXT,
    item_sleeve TEXT,
    item_neckline TEXT,
    item_ornament TEXT,
    
    FOREIGN KEY (id) REFERENCES items(id)
);