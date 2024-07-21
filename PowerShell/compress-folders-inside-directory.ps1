# Set the root directory
$rootDir = ""

# Check if the root directory exists
if (-Not (Test-Path -Path $rootDir)) {
    Write-Error "The specified root directory does not exist: $rootDir"
    exit
}

# Get all subdirectories in the root directory
$subDirs = Get-ChildItem -Path $rootDir -Directory

# Loop through each subdirectory
foreach ($subDir in $subDirs) {
    try {
        # Set the name for the zip file (same as the subdirectory name)
        $zipFileName = "$($subDir.Name).zip"
        
        # Set the path for the zip file in the root directory
        $zipFilePath = Join-Path -Path $rootDir -ChildPath $zipFileName
        
        # Get all files in the subdirectory
        $filesToZip = Get-ChildItem -Path $subDir.FullName -File
        
        # Compress the contents of the subdirectory
        Compress-Archive -Path $filesToZip.FullName -DestinationPath $zipFilePath
        
        # Verify if the zip file was created
        if (Test-Path -Path $zipFilePath) {
            # Remove the original subdirectory
            Remove-Item -Path $subDir.FullName -Recurse
        } else {
            Write-Error "Failed to create zip file: $zipFilePath"
        }
    } catch {
        Write-Error "An error occurred: $_"
    }
}

Write-Output "Compression and relocation completed."