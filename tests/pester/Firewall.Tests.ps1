Describe 'The firewall' {
    $ufwOutput = & sudo ufw status
    
    Context 'on the machine' {
        It 'should return a status' {
            $ufwOutput | Should Not Be $null
            $ufwOutput.GetType().FullName | Should Be 'System.Object[]'
            $ufwOutput.Length | Should Be 7
        }

        It 'should be enabled' {
            $ufwOutput[0] | Should Be 'Status: active'
        }
    }

    Context 'should allow SSH' {
        It 'on port 22' {
            ($ufwOutput | Where-Object {$_ -match '(22)\s*(ALLOW)\s*(Anywhere)'} ) | Should Not Be ''
        }
    }

    Context 'should allow consul' {
        It 'on port 8300' {

        }

        It 'on port 8301' {

        }

        It 'on port 8500' {

        }

        It 'on port 8600' {

        }
    }

    Context 'should allow nomad' {
        It 'on port 4646' {

        }

        It 'on port 4647' {

        }
    }
        
    Context 'should allow vault' {
        It 'on port 8200'{

        }

        It 'on port 8201' {
            
        }
    }
}