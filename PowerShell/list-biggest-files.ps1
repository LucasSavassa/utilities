function Get-HumanReadableSize {
    param ([long]$bytes)

    switch ($bytes) {
        { $_ -ge 1GB } { return "{0:N2} GB" -f ($bytes / 1GB) }
        { $_ -ge 1MB } { return "{0:N2} MB" -f ($bytes / 1MB) }
        { $_ -ge 1KB } { return "{0:N2} KB" -f ($bytes / 1KB) }
        default        { return "$bytes B" }
    }
}

# Change the path below as needed
$path = "C:\"

Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue |
    Sort-Object Length -Descending |
    Select-Object -First 20 |
    ForEach-Object {
        $size = Get-HumanReadableSize $_.Length
        "$size | $($_.FullName)"
    }