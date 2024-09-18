
import ballerina/sql;
import ballerinax/java.jdbc;
import ballerina/log;

// JDBC client configuration
jdbc:Client dbClient = new ({
    url: "jdbc:postgresql://localhost:5432/etl_pipeline",
    username: "your_username",
    password: "your_password",
    poolOptions: { maximumPoolSize: 5 }
});

public function loadDataToDatabase(json[] data) returns error? {
    foreach json row in data {
        json name = row.name;
        json age = row.age;
        json department = row.department;

        // Insert data into the PostgreSQL table
        sql:ParameterizedQuery sqlQuery = `INSERT INTO employee_data (name, age, department)
                                           VALUES (${name}, ${age}, ${department})`;
        check dbClient->execute(sqlQuery);
    }
    log:printInfo("Data loaded into PostgreSQL");
}
