
import ballerina/log;
import ballerina/io;
import ./modules.extract as extractModule;
import ./modules.transform as transformModule;
import ./modules.load as loadModule;

public function main() returns error? {
    // Step 1: Extract data from CSV
    log:printInfo("Starting ETL process");
    json[] extractedData = check extractModule.extractDataFromCSV();

    // Step 2: Transform the extracted data
    json[] transformedData = transformModule.transformData(extractedData);

    // Step 3: Load the transformed data into PostgreSQL
    check loadModule.loadDataToDatabase(transformedData);

    log:printInfo("ETL process completed successfully");
}
