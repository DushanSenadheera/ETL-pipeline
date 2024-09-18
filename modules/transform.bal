
import ballerina/log;

public function transformData(json[] rawData) returns json[] {
    json[] transformedData = [];

    foreach json row in rawData {
        json name = row.name;
        json age = row.age;
        json department = row.department;

        // Filter out rows with invalid data
        if name is string && department is string {
            // Ensure age is an integer, skip invalid rows
            int? ageInt = check 'int:fromString(age.toString());
            if ageInt is () {
                log:printWarn("Invalid data for age: " + age.toString());
                continue;
            }

            // Add cleaned and transformed data to the array
            transformedData.push({
                name: name,
                age: ageInt,
                department: department
            });
        }
    }

    log:printInfo("Transformed data");
    return transformedData;
}
