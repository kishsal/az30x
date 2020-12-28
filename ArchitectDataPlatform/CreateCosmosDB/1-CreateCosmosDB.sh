### Follow the steps on here: https://docs.microsoft.com/en-us/learn/modules/create-cosmos-db-for-scale/2-create-an-account


### Create a new .NET App, database and containers using C#

#Create new .NET console app
dotnet new console --output myApp

#change directory
cd myApp

# Add the Microsoft.Azure.Cosmos NuGet package as a project dependency
dotnet add package Microsoft.Azure.Cosmos --version 3.0.0

#Restore all packages specified as dependencies in the project and compile the project
dotnet restore
dotnet build

#In azure shell, open code
code .

#Click myApp.csproj in the Explorer and add the following:
<Project Sdk="Microsoft.NET.Sdk">
    <PropertyGroup>
        <OutputType>Exe</OutputType>
        <TargetFramework>netcoreapp2.2</TargetFramework>
    </PropertyGroup>
    <PropertyGroup>
        <LangVersion>latest</LangVersion>
    </PropertyGroup>
    <ItemGroup>
        <PackageReference Include="Microsoft.Azure.Cosmos" Version="3.0.0" />
    </ItemGroup>
</Project>

#Click Program.cs  and add the following:
#Add URI and Key from CosmosDB
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Azure.Cosmos;

namespace myApp
{
    public class Program
    {
        private static readonly string _endpointUri = "YOUR_URI";
        private static readonly string _primaryKey = "YOUR_KEY";
        public static async Task Main(string[] args)
        {         
            using (CosmosClient client = new CosmosClient(_endpointUri, _primaryKey))
            {        
                DatabaseResponse databaseResponse = await client.CreateDatabaseIfNotExistsAsync("Products");
                Database targetDatabase = databaseResponse.Database;
                await Console.Out.WriteLineAsync($"Database Id:\t{targetDatabase.Id}");
            }
        }
    }
}


#Compile and run
dotnet build
dotnet run

