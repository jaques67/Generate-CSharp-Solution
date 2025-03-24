# Generate C# Solution

## Description
This Powershell script is used to generate a C# solution with projects that are often included.
The script will also create a generic README.md file containing the solution name as a header.

## Usage

Open the powershell script and remove the project types your are not interested in.

Update the first three lines, shown below with the solution name and the path if interested. Removing the `.\subFolder\` will create the solution folder at the location where the script is being run.

``` powershell
$solutionName = "MyApplication"
$solutionPath = ".\subFolder\$solutionName\"
$sourcePath = ".\subFolder\$solutionName\"
```

## Running Script
We can generate either a .NET Framework or .NET Core solution.
If the framework is not specified, net8.0 will be used.
``` powershell
.\GenerateNewSolution.ps1 -frameworkVersion "net6.0"
.\GenerateNewSolution.ps1 -frameworkVersion "net47" -isNetFramework
```

The project type will be displayed during project generation.
After the project has been generated, we can run the following command to check

``` powershell
Get-Content "path\to\project\projectname.csproj"
```

## Framework Supported Versions
``` powershell
net45 (.NET Framework 4.5)
net451 (.NET Framework 4.5.1)
net452 (.NET Framework 4.5.2)
net46 (.NET Framework 4.6)
net461 (.NET Framework 4.6.1)
net462 (.NET Framework 4.6.2)
net47 (.NET Framework 4.7)
net471 (.NET Framework 4.7.1)
net472 (.NET Framework 4.7.2)
net48 (.NET Framework 4.8)
```

## TODO
Determine how to generate a SQL Server Database project.
