
import ballerina/csv;
import ballerina/io;
import ballerina/log;

public function extractDataFromCSV() returns json[]|error {
    io:ReadableCSVChannel csvChannel = check io:openReadableCsvFile("../resources/employee_data.csv");
    json[] dataRows = [];

    // Skip the header row
    check csvChannel.readNext();

    // Read the CSV file line by line
    while true {
        string?[] row = check csvChannel.readNext();
        if row is () {
            break;
        }
        json rowData = {
            name: row[0],
            age: row[1],
            department: row[2]
        };
        dataRows.push(rowData);
    }

    check csvChannel.close();
    log:printInfo("Extracted data from CSV");
    return dataRows;
}
