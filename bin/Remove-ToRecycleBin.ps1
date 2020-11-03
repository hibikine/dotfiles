[CmdletBinding(SupportsShouldProcess = $True, DefaultParameterSetName = 'Path')]
Param (
    [SupportsWildCards()]
    [Parameter(
        Mandatory = $True,
        Position = 0,
        ParameterSetName = 'Path',
        ValueFromPipeline = $True,
        ValueFromPipelineByPropertyName = $True
    )]
    [string[]]$Path,

    [Alias('LP')]
    [Alias('PSPath')]
    [Parameter(
        Mandatory = $True,
        Position = 0,
        ParameterSetName = 'LiteralPath',
        ValueFromPipeline = $False,
        ValueFromPipelineByPropertyName = $True
    )]
    [string[]]$LiteralPath
)
Begin {
    $shell = New-Object -ComObject Shell.Application
    $trash = $shell.NameSpace(10)
}
Process {
    if ($PSBoundParameters.ContainsKey('Path')) {
        $targets = Convert-Path $Path
    } else {
        $targets = Convert-Path -LiteralPath $LiteralPath
    }
    $targets | Foreach-Object {
        if ($PSCmdlet.ShouldProcess($_)) {
            $trash.MoveHere($_)
        }
    }
}