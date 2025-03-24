# Add a parameter for the .NET version
param(
    [string]$frameworkVersion = "net8.0",  # Default to .NET 8.0 if not specified
    [switch]$isNetFramework = $false       # Flag to indicate if this is .NET Framework
)

# Define the parameters
$solutionName = "MassParameterDaemon"
$solutionPath = "..\$solutionName\"
$sourcePath = "..\$solutionName\src\"
$readmeFilePath = "$($solutionPath)\README.md"
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
$testProjectName = "$($solutionName).Test"

# Function to create a .NET Framework project
function New-NetFrameworkProject {
    param (
        [string]$projectName,
        [string]$projectPath,
        [string]$projectType,
        [string]$frameworkVersion
    )
    
    # Create project directory if it doesn't exist
    New-Item -ItemType Directory -Force -Path $projectPath | Out-Null
    
    Write-Output "Creating $projectType project: $projectName (.NET Framework $frameworkVersion)"
    
    # Create the .csproj file
    $csprojContent = @"
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <Import Project="\`$(MSBuildExtensionsPath)\`$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('\`$(MSBuildExtensionsPath)\`$(MSBuildToolsVersion)\Microsoft.Common.props')" />
  <PropertyGroup>
    <Configuration Condition=" '\`$(Configuration)' == '' ">Debug</Configuration>
    <Platform Condition=" '\`$(Platform)' == '' ">AnyCPU</Platform>
    <ProjectGuid>{$(New-Guid)}</ProjectGuid>
    <OutputType>$projectType</OutputType>
    <RootNamespace>$projectName</RootNamespace>
    <AssemblyName>$projectName</AssemblyName>
    <TargetFrameworkVersion>v$frameworkVersion</TargetFrameworkVersion>
    <FileAlignment>512</FileAlignment>
    <AutoGenerateBindingRedirects>true</AutoGenerateBindingRedirects>
    <Deterministic>true</Deterministic>
  </PropertyGroup>
  <PropertyGroup Condition=" '\`$(Configuration)|\`$(Platform)' == 'Debug|AnyCPU' ">
    <DebugSymbols>true</DebugSymbols>
    <DebugType>full</DebugType>
    <Optimize>false</Optimize>
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <PropertyGroup Condition=" '\`$(Configuration)|\`$(Platform)' == 'Release|AnyCPU' ">
    <DebugType>pdbonly</DebugType>
    <Optimize>true</Optimize>
    <OutputPath>bin\Release\</OutputPath>
    <DefineConstants>TRACE</DefineConstants>
    <ErrorReport>prompt</ErrorReport>
    <WarningLevel>4</WarningLevel>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="System" />
    <Reference Include="System.Core" />
    <Reference Include="System.Xml.Linq" />
    <Reference Include="System.Data.DataSetExtensions" />
    <Reference Include="Microsoft.CSharp" />
    <Reference Include="System.Data" />
    <Reference Include="System.Net.Http" />
    <Reference Include="System.Xml" />
  </ItemGroup>
  <ItemGroup>
    <Compile Include="Properties\AssemblyInfo.cs" />
  </ItemGroup>
  <Import Project="\`$(MSBuildToolsPath)\Microsoft.CSharp.targets" />
</Project>
"@
    
    # Create AssemblyInfo.cs
    $assemblyInfoContent = @"
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

[assembly: AssemblyTitle("$projectName")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("")]
[assembly: AssemblyProduct("$projectName")]
[assembly: AssemblyCopyright("Copyright \$(Get-Date -Format yyyy)")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]
[assembly: ComVisible(false)]
[assembly: Guid("\$(New-Guid)")]
[assembly: AssemblyVersion("1.0.0.0")]
[assembly: AssemblyFileVersion("1.0.0.0")]
"@
    
    # Create the project structure
    New-Item -ItemType Directory -Force -Path "$projectPath\Properties" | Out-Null
    Set-Content -Path "$projectPath\$projectName.csproj" -Value $csprojContent
    Set-Content -Path "$projectPath\Properties\AssemblyInfo.cs" -Value $assemblyInfoContent
}

Write-Output "create solution"
# Create the solution
dotnet new sln --output $solutionPath

Write-Output "`nCreate Projects"
# Create the projects based on framework type
if ($isNetFramework) {
    Write-Output "Creating .NET Framework projects..."
    # Extract version number (e.g., "net47" -> "4.7")
    $frameworkNum = $frameworkVersion -replace 'net', ''
    $dotNetVersion = "$($frameworkNum[0]).$($frameworkNum.Substring(1))"
    
    # Create .NET Framework projects
    New-NetFrameworkProject -projectName $dataProjectName -projectPath "$sourcePath\$dataProjectName" -projectType "Library" -frameworkVersion $dotNetVersion
    New-NetFrameworkProject -projectName $repositoryProjectName -projectPath "$sourcePath\$repositoryProjectName" -projectType "Library" -frameworkVersion $dotNetVersion
    New-NetFrameworkProject -projectName $libraryProjectName -projectPath "$sourcePath\$libraryProjectName" -projectType "Library" -frameworkVersion $dotNetVersion
    New-NetFrameworkProject -projectName $gatewayProjectName -projectPath "$sourcePath\$gatewayProjectName" -projectType "Library" -frameworkVersion $dotNetVersion
    New-NetFrameworkProject -projectName $dtoProjectName -projectPath "$sourcePath\$dtoProjectName" -projectType "Library" -frameworkVersion $dotNetVersion
    New-NetFrameworkProject -projectName $commonProjectName -projectPath "$sourcePath\$commonProjectName" -projectType "Library" -frameworkVersion $dotNetVersion
    New-NetFrameworkProject -projectName $iocProjectName -projectPath "$sourcePath\$iocProjectName" -projectType "Library" -frameworkVersion $dotNetVersion
    New-NetFrameworkProject -projectName $consoleProjectName -projectPath "$sourcePath\$consoleProjectName" -projectType "Exe" -frameworkVersion $dotNetVersion
    
    Write-Output "Note: Web API, Blazor, and some other project types are not supported in .NET Framework $dotNetVersion"
    Write-Output "Please create these projects manually in Visual Studio if needed."
} else {
    Write-Output "Creating .NET Core/5+ projects..."
    # Create .NET Core/5+ projects as before
    foreach ($project in @(
        @{Name=$dataProjectName; Type="classlib"},
        @{Name=$repositoryProjectName; Type="classlib"},
        @{Name=$libraryProjectName; Type="classlib"},
        @{Name=$apiProjectName; Type="webapi"},
        @{Name=$gatewayProjectName; Type="classlib"},
        @{Name=$consoleProjectName; Type="console"},
        @{Name=$wpfProjectName; Type="wpf"},
        @{Name=$blazorProjectName; Type="blazorserver"},
        @{Name=$dtoProjectName; Type="classlib"},
        @{Name=$commonProjectName; Type="classlib"},
        @{Name=$iocProjectName; Type="classlib"},
        @{Name=$testProjectName; Type="xunit"}
    )) {
        Write-Output "Creating $($project.Type) project: $($project.Name) ($frameworkVersion)"
        dotnet new $project.Type -n $project.Name -o "$sourcePath\$($project.Name)" --framework $frameworkVersion
    }
}

Write-Output "Add Projects to solution"
# Add all existing .csproj files to the solution
Get-ChildItem -Path $sourcePath -Recurse -Filter "*.csproj" | ForEach-Object {
    dotnet sln "$solutionPath$solutionName.sln" add $_.FullName
}

Write-Output "Creating README.md file"
New-Item -Path $readmeFilePath -ItemType File -Force

$readmeContent = "# $solutionName"
Set-Content -Path $readmeFilePath -Value $readmeContent

Write-Output "Solution and project generation have been completed"
