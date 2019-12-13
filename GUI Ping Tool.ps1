### wielkość okna ###
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '600,500'
$Form.text                       = "Ping Tool"
$Form.TopMost                    = $false
### ping ###
$Ping1                         = New-Object system.Windows.Forms.Button
$Ping1.text                    = "PING"
$Ping1.width                   = 150
$Ping1.height                  = 24
$Ping1.location                = New-Object System.Drawing.Point(290,10)
$Ping1.Font                    = 'Microsoft Sans Serif,10'
$PING1.Add_Click({pingtest1})
### ping via domains ###
$Ping2                         = New-Object system.Windows.Forms.Button
$Ping2.text                    = "PING VIA DOMAINS"
$Ping2.width                   = 150
$Ping2.height                  = 24
$Ping2.location                = New-Object System.Drawing.Point(290,40)
$Ping2.Font                    = 'Microsoft Sans Serif,10'
$PING2.Add_Click({pingtest2})
### Domain check ###
$dns                         = New-Object system.Windows.Forms.Button
$dns.text                    = "NSLOOKUP"
$dns.width                   = 150
$dns.height                  = 24
$dns.location                = New-Object System.Drawing.Point(440,40)
$dns.Font                    = 'Microsoft Sans Serif,10'
$dns.Add_Click({domaincheck})
### traceroute ###
$traceroute                         = New-Object system.Windows.Forms.Button
$traceroute.text                    = "TRACEROUTE"
$traceroute.width                   = 150
$traceroute.height                  = 24
$traceroute.location                = New-Object System.Drawing.Point(440,10)
$traceroute.Font                    = 'Microsoft Sans Serif,10'
$traceroute.Add_Click({traceroute})
### insert machine name ###
$MachineID                        = New-Object system.Windows.Forms.TextBox
$MachineID.multiline              = $false
$MachineID.width                  = 250
$MachineID.height                 = 50
$MachineID.location               = New-Object System.Drawing.Point(20,40)
$MachineID.Font                   = 'Microsoft Sans Serif,10'
### inser machine text ###
$Text1                          = New-Object system.Windows.Forms.Label
$Text1.text                     = " ENTER IP / HOSTNAME"
$Text1.AutoSize                 = $false
$Text1.width                    = 250
$Text1.height                   = 50
$Text1.location                 = New-Object System.Drawing.Point(20,10)
$Text1.Font                     = 'Microsoft Sans Serif,15,style=Bold'
################################# uptime button
$UPTIME                          = New-Object system.Windows.Forms.Button
$UPTIME.text                     = "UPTIME"
$UPTIME.BackColor                = "#7ed231"
$UPTIME.width                    = 110
$UPTIME.height                   = 30
$UPTIME.location                 = New-Object System.Drawing.Point(785,50)
$UPTIME.Font                     = 'Microsoft Sans Serif,10,style=Bold'
$UPTIME.Add_Click({uptimecheck})
################################# copyright sign
$createdby                       = New-Object system.Windows.Forms.Label
$createdby.text                  = "Copyright Ⓒ 2019 by Przemyslaw Ludwig"
$createdby.AutoSize              = $true
$createdby.width                 = 25
$createdby.height                = 10
$createdby.location              = New-Object System.Drawing.Point(320,480)
$createdby.Font                  = 'Microsoft Sans Serif,10,style=Bold'
### output window ###
$Outputbox                       = New-Object system.Windows.Forms.TextBox
$Outputbox.multiline             = $true
$Outputbox.width                 = 580
$Outputbox.height                = 400
$Outputbox.location              = New-Object System.Drawing.Point(10,70)
$Outputbox.Font                  = 'Microsoft Sans Serif,10'
$outputBox.ScrollBars            = "Vertical"
$Form.Controls.Add($outputBox)

$Form.controls.AddRange(@($Ping1,$Ping2,$MachineID,$Outputbox,$Text1,$dns,$traceroute,$UPTIME,$createdby))
$Form.Add_Shown({$Form.Activate()})


### function ###
Function pingtest1 {
  BEGIN {
  }

  PROCESS {
     $OutputBox.Text = "Please Wait..."
     $ping = ping ($MachineID.text)
     $OutputBox.Text = ""
     foreach ($line in $ping) {
         $OutputBox.Appendtext($line+[char]13+[char]10)
     }
  }

  END {
  }
}

function pingtest2

{
$OutputBox.Text = "Please Wait..."
$Domains= '.domain1.xyz','.domain2.com' # change domain name and try ;), you need to remember to add ,, . " before domain path, for example .domain.xyz

$Serwer=$MachineID.text;
foreach ($Domain in $Domains)
    {
      foreach ($line in ping $serwer$domain | fl | out-string){
    }
$Outputbox.Appendtext($line);}

} 

Function domaincheck {
  BEGIN {
  }

  PROCESS {
     $OutputBox.Text = "Please Wait..."
     $nslookup = nslookup ($MachineID.text)
     $OutputBox.Text = ""
     foreach ($line in $nslookup) {
         $OutputBox.Appendtext($line+[char]13+[char]10)
     }
  }

  END {
  }
}

Function traceroute {
  BEGIN {
  }

  PROCESS {
     $OutputBox.Text = "Please Wait..."
     $tracert = tracert ($MachineID.text)
     $OutputBox.Text = ""
     foreach ($line in $tracert) {
         $OutputBox.Appendtext($line+[char]13+[char]10)
     }
  }

  END {
  }
}

function uptimecheck

{   $Serwer= $InputBox.text;

 

    $uptime = Invoke-Command -ComputerName $Serwer -Credential $credentials { Get-CimInstance -ClassName win32_operatingsystem | Select-Object lastbootuptime } -ErrorAction Stop

 

    $outputBox.text=$uptime | fl | out-string;
}

$Form.Add_Shown({$Form.Activate()})

 

$Form.ShowDialog()