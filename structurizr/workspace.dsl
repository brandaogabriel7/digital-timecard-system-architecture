workspace {

    model {
        // Person and Software System definitions

        employee = person "Employee" "An employee that uses the timecard system to punch in and out of work"
        manager = person "Manager" "A manager that approves timecards"
        timecardSystem = softwareSystem "Software System" "A software system that allows employees to punch in and out of work" {
            keycloak = container "Keycloak" "Used to authenticate employees" "Keycloak"
            database = container "Database" "Stores information about employees, timecards, etc" "PostgreSQL"
            kafka = container "Kafka" "A message broker used to send messages between the timecard system and the database" "Kafka"
            webApp = container "Web App" "A web application that allows employees to punch in and out of work and managers to approve timecards" "React"
            api = container "API" "An API that allows the web app to communicate with the timecard system" "Golang"
        }

        // Person-Container relationships

        employee -> webApp "Punches In/Out, Views Timecards"
        manager -> webApp "Approves Timecards"

        // Container-Container relationships

        webApp -> api "Authenticates users, sends/receives data"
        api -> keycloak "Authenticates users"
        api -> kafka "Sendsa and retrieves timecard data"
        kafka -> database "Stores timecard data"
    }

    // Views section

    views {
        themes default "https://static.structurizr.com/themes/microsoft-azure-2023.01.24/theme.json"
        systemContext timecardSystem "SystemContext" {
            include *
            autoLayout
        }

        container timecardSystem "ContainerContext" {
            include *
            autoLayout
        }
    }

}
