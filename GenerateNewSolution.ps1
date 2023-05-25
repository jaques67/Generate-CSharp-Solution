Write-Output "Setup Solution and Project Names to be generated"
# Define the parameters
$solutionName = "MyApplication"
$solutionPath = ".\subFolder\$solutionName\"
$sourcePath = ".\subFolder\$solutionName\"
$dataProjectName = "$($solutionName).Data"
$repositoryProjectName = "$($solutionName).Repository"
$libraryProjectName = "$($solutionName).Library"
$apiProjectName = "$($solutionName).Api"
$gatewayProjectName = "$($solutionName).Gateway"
$consoleProjectName = "$($solutionName).UI.Console"
$wpfProjectName = "$($solutionName).UI.Wpf"
$blazorProjectName = "$($solutionName).UI.Blazor"
$dtoProjectName = "$($solutionName).Dto"
$commonProjectName = "$($solutionName).Common"
$iocProjectName = "$($solutionName).Ioc"
#$dbProjectName = "$($solutionName).Db"
$testProjectName = "$($solutionName).Test"

Write-Output "Create solution"
# Create the solution
dotnet new sln --output $solutionPath

Write-Output "Generate projects"
# Create the projects
dotnet new classlib -n $dataProjectName -o "$sourcePath\$dataProjectName"
dotnet new classlib -n $repositoryProjectName -o "$sourcePath\$repositoryProjectName"
dotnet new classlib -n $libraryProjectName -o "$sourcePath\$libraryProjectName"
dotnet new webapi -n $apiProjectName -o "$sourcePath\$apiProjectName"
dotnet new classlib -n $gatewayProjectName -o "$sourcePath\$gatewayProjectName"
dotnet new console -n $consoleProjectName -o "$sourcePath\$consoleProjectName"
dotnet new wpf -n $wpfProjectName -o "$sourcePath\$wpfProjectName"
dotnet new blazorserver -n $blazorProjectName -o "$sourcePath\$blazorProjectName"
dotnet new classlib -n $dtoProjectName -o "$sourcePath\$dtoProjectName"
dotnet new classlib -n $commonProjectName -o "$sourcePath\$commonProjectName"
dotnet new classlib -n $iocProjectName -o "$sourcePath\$iocProjectName"
#dotnet new sqlserver -n $dbProjectName -o "$sourcePath\$dbProjectName"
dotnet new xunit -n $testProjectName -o "$sourcePath\$testProjectName"

Write-Output "Add projects to the solution"
# Add the projects to the solution
# dotnet sln "$sourcePath\$solutionName.sln" add myapp\myapp.csproj
dotnet sln "$sourcePath$solutionName.sln" add `
    "$sourcePath\$dataProjectName\$dataProjectName.csproj" `
    "$sourcePath\$repositoryProjectName\$repositoryProjectName.csproj" `
    "$sourcePath\$libraryProjectName\$libraryProjectName.csproj" `
    "$sourcePath\$apiProjectName\$apiProjectName.csproj" `
    "$sourcePath\$gatewayProjectName\$gatewayProjectName.csproj" `
    "$sourcePath\$consoleProjectName\$consoleProjectName.csproj" `
    "$sourcePath\$wpfProjectName\$wpfProjectName.csproj" `
    "$sourcePath\$blazorProjectName\$blazorProjectName.csproj" `
    "$sourcePath\$dtoProjectName\$dtoProjectName.csproj" `
    "$sourcePath\$commonProjectName\$commonProjectName.csproj" `
    "$sourcePath\$iocProjectName\$iocProjectName.csproj" `
#    "$sourcePath\$dbProjectName\$dbProjectName.sqlproj" `
    "$sourcePath\$testProjectName\$testProjectName.csproj"

    Write-Output "Solution and project generation have been completed"
