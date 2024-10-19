# Define the directory containing the zip files
$rootDirectory = ""

# Get all zip files in the directory
$zipFiles = Get-ChildItem -Path $rootDirectory -Filter *.zip

# Loop through each zip file and extract its contents
foreach ($zipFile in $zipFiles) {
    # Define the destination folder for the extracted contents
    $destinationFolder = Join-Path $rootDirectory -ChildPath ($zipFile.BaseName)

    # Create the destination folder if it doesn't exist
    if (-not (Test-Path $destinationFolder)) {
        New-Item -Path $destinationFolder -ItemType Directory
    }

    # Extract the zip file to the destination folder
    Expand-Archive -Path $zipFile.FullName -DestinationPath $destinationFolder -Force
}

Write-Host "All zip files have been extracted."