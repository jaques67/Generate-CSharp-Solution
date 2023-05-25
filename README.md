# Generate C# Solution

## Description
This Powershell script is used to generate a C# solution with projects that are often included.

## Usage

Open the powershell script and remove the project types your are not interested in.

Update the first three lines, shown below with the solution name and the path if interested. Removing the `.\subFolder\` will create the solution folder at the location where the script is being run.

``` powershell
$solutionName = "MyApplication"
$solutionPath = ".\subFolder\$solutionName\"
$sourcePath = ".\subFolder\$solutionName\"
```

## TODO
Determine how to generate a SQL Server Database project.
