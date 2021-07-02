function Remove-FilesPathForDate{

    <#

        .SYNOPSIS

            Función que permite eliminar archivos de un repositorio con una antiguedad establecida.

 

        .DESCRIPTION

            Remove-FilesPathForDate, elimina archivos con una antiguedad mayor a Days días establecidos

            como parámetro de entrada en una ruta Path establecida.

 

        .PARAMETER Path

            Ruta local o remota donde se van a eliminar los archivos.

 

        .PARAMETER Days

            Número de días de antiguedad para la eliminación de archivos. Se eliminaran todos los archivos con

            una fecha de creación anterior a la fecha actual menos Days.

 

        .EXAMPLE

            Eliminar todos los archivos de la ruta local .\ con una antiguedad de creación mayor a 60 días

            Remove-FilesPathForDate -Path .\ -Days 60

             

        .EXAMPLE

            Elimina todos los archivos de la carpeta remota \\172.29.80.81\Compartidas\carpeta-prueba\, con una

            antiguedad de creación mayor a 30 días, y muestra los detalles de la eliminación por consola (-Verbose) .

           Remove-FilesPathForDate -Path "\\172.15.80.81\Compartidas\carpeta-prueba\" -Days 30 -Verbose.

 

        .EXAMPLE

            Simula la eliminación de los archivos en la ruta específica con una antiguedad mayor a 6 días.

             Remove-FilesPathForDate -Path .\ -Days 6 -WhatIf

 

        .INPUTS

            String

            Int

 

        .OUTPUTS

            String

 

        .NOTES

            Author:   Luis Gerardo Collazos Castro

            Website:  ingerti.com

            GitHub:   github.com/lugercocas

    #>

 

    [CmdletBinding(SupportsShouldProcess)]

    param (

        [Parameter(Mandatory=$True)]

        [string[]]$Path,

        [Parameter(Mandatory=$True)]

        [int]$Days

    )

    Get-ChildItem -Path $Path -File * |

    Where-Object { ($_.CreationTime.CompareTo((Get-Date).AddDays(-$Days))) -cle 0 } |

    Select-Object FullName, CreationTime | ForEach-Object{   

        Remove-Item $_.FullName -WhatIf

        Write-Verbose "Deleting File: $_"

    }

 

}

