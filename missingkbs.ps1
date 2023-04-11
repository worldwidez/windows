# PowerShell script to list all missing security-related KBs on a Windows 10 or 11 machine in a table format, including KB article ID, title, and description

$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()
$Criteria = "IsInstalled=0 and Type='Software' and CategoryIDs contains 'E6CF1350-C01B-414D-A61F-263D14D133B4'"
$SearchResult = $Searcher.Search($Criteria).Updates

if($SearchResult.Count -eq 0){
    Write-Host "No missing security-related KBs found"
}
else{
    $KBUpdates = @()

    foreach($Update in $SearchResult){
        $Title = $Update.Title
        $KBArticleIDs = $Update.KBArticleIDs
        $Description = $Update.Description
        $SupportUrl = $Update.SupportUrl
        $Categories = $Update.Categories | Select-Object -ExpandProperty Name
        $ReleaseDate = $Update.LastDeploymentChangeTime
        $KBUpdates += New-Object psobject -Property @{
            KBArticleID = $KBArticleIDs
            Title = $Title
            Description = $Description
            SupportUrl = $SupportUrl
            Categories = $Categories -join ', '
            ReleaseDate = $ReleaseDate
        }
    }

    $KBUpdates | Sort-Object KBArticleID | Format-Table @{Label="KB Article ID";Expression={$_.KBArticleID};width=20}, @{Label="Title";Expression={$_.Title};width=40}, @{Label="Description";Expression={$_.Description};width=80}, @{Label="Support URL";Expression={$_.SupportUrl};width=60}, @{Label="Categories";Expression={$_.Categories};width=40}, @{Label="Release Date";Expression={$_.ReleaseDate};width=20} -Wrap
}
