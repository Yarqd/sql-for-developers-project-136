CREATE TABLE programs(
    id BIGINT PRIMARY KEY,
    title VARCHAR (50) NOT NULL,
    price NUMERIC (10, 2) NOT NULL,
    type VARCHAR (30) NOT NULL,
    description text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE modules(
    id BIGINT PRIMARY KEY,
    title VARCHAR (50) NOT NULL,
    description text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses(
    id BIGINT PRIMARY KEY,
    title VARCHAR (50) NOT NULL,
    description text,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lessons(
    id BIGINT PRIMARY KEY,
    title VARCHAR (50) NOT NULL,
    content text,
    video_url VARCHAR (200),
    position   INT NOT NULL CHECK (position > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    course_id BIGINT NOT NULL REFERENCES Courses(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE module_courses (
    module_id BIGINT NOT NULL REFERENCES modules (id) ON DELETE CASCADE,
    course_id BIGINT NOT NULL REFERENCES courses (id) ON DELETE CASCADE,
    PRIMARY KEY (module_id, course_id)
);

CREATE TABLE program_modules (
    program_id BIGINT NOT NULL REFERENCES programs (id) ON DELETE CASCADE,
    module_id BIGINT NOT NULL REFERENCES modules (id) ON DELETE CASCADE,
    PRIMARY KEY (program_id, module_id)
);

CREATE TYPE user_role AS ENUM ('student', 'teacher', 'admin');
CREATE TABLE users(
    id BIGINT PRIMARY KEY,
    name VARCHAR (50) NOT NULL,
    role user_role NOT NULL,
    email text NOT NULL,
    password VARCHAR (50) NOT NULL,
    teaching_group_id BIGINT NOT NULL REFERENCES teaching_groups(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE teaching_groups (
    id BIGINT PRIMARY KEY,
    slug VARCHAR (20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)