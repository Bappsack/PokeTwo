#include-once

#region Constants
;~ http://msdn.microsoft.com/library/aa379607.aspx
Global Const $__DELETE                                  = 0x00010000
Global Const $__READ_CONTROL                            = 0x00020000
Global Const $__WRITE_DAC                               = 0x00040000
Global Const $__WRITE_OWNER                             = 0x00080000
Global Const $__SYNCHRONIZE                             = 0x00100000

Global Const $__STANDARD_RIGHTS_READ                    = 0x00020000
Global Const $__STANDARD_RIGHTS_WRITE                   = $__STANDARD_RIGHTS_READ
Global Const $__STANDARD_RIGHTS_EXECUTE                 = $__STANDARD_RIGHTS_READ
Global Const $__STANDARD_RIGHTS_REQUIRED                = BitOR($__DELETE, $__READ_CONTROL, $__WRITE_DAC, $__WRITE_OWNER)
Global Const $__STANDARD_RIGHTS_ALL                     = BitOR($__STANDARD_RIGHTS_REQUIRED, $__SYNCHRONIZE)

;~ http://msdn.microsoft.com/library/aa379321.aspx
Global Const $__ACCESS_SYSTEM_SECURITY                  = 0x01000000

;~ http://msdn.microsoft.com/library/ms684880.aspx
Global Const $__PROCESS_TERMINATE                       = 0x0001
Global Const $__PROCESS_CREATE_THREAD                   = 0x0002
Global Const $__PROCESS_VM_OPERATION                    = 0x0008
Global Const $__PROCESS_VM_READ                         = 0x0010
Global Const $__PROCESS_VM_WRITE                        = 0x0020
Global Const $__PROCESS_DUP_HANDLE                      = 0x0040
Global Const $__PROCESS_CREATE_PROCESS                  = 0x0080
Global Const $__PROCESS_SET_QUOTA                       = 0x0100
Global Const $__PROCESS_SET_INFORMATION                 = 0x0200
Global Const $__PROCESS_QUERY_INFORMATION               = 0x0400
Global Const $__PROCESS_SUSPEND_RESUME                  = 0x0800
Global Const $__PROCESS_QUERY_LIMITED_INFORMATION       = 0x1000 ; Windows Server 2003 and Windows XP: This access right is not supported.
Global Const $__PROCESS_ALL_ACCESS_BS6000               = BitOR($__STANDARD_RIGHTS_REQUIRED, $__SYNCHRONIZE, 0x0FFF)
Global Const $__PROCESS_ALL_ACCESS_BB6000               = BitOR($__STANDARD_RIGHTS_REQUIRED, $__SYNCHRONIZE, 0xFFFF)
Global       $__PROCESS_ALL_ACCESS
If @OSBuild < 6000 Then
    $__PROCESS_ALL_ACCESS = $__PROCESS_ALL_ACCESS_BS6000
Else
    $__PROCESS_ALL_ACCESS = $__PROCESS_ALL_ACCESS_BB6000
EndIf

;~ ;~ http://msdn.microsoft.com/library/aa374905.aspx
;~ Global Const $__TOKEN_ASSIGN_PRIMARY                    = 0x0001
;~ Global Const $__TOKEN_DUPLICATE                         = 0x0002
;~ Global Const $__TOKEN_IMPERSONATE                       = 0x0004
;~ Global Const $__TOKEN_QUERY                             = 0x0008
;~ Global Const $__TOKEN_QUERY_SOURCE                      = 0x0010
;~ Global Const $__TOKEN_ADJUST_PRIVILEGES                 = 0x0020
;~ Global Const $__TOKEN_ADJUST_GROUPS                     = 0x0040
;~ Global Const $__TOKEN_ADJUST_DEFAULT                    = 0x0080
;~ Global Const $__TOKEN_ADJUST_SESSIONID                  = 0x0100
;~ Global Const $__TOKEN_EXECUTE                           = $__STANDARD_RIGHTS_EXECUTE
;~ Global Const $__TOKEN_READ                              = BitOR($__STANDARD_RIGHTS_READ, $__TOKEN_QUERY)
;~ Global Const $__TOKEN_WRITE                             = BitOR($__STANDARD_RIGHTS_WRITE, $__TOKEN_ADJUST_PRIVILEGES, $__TOKEN_ADJUST_GROUPS, $__TOKEN_ADJUST_DEFAULT)
;~ Global Const $__TOKEN_ALL_ACCESS_P                      = BitOR($__STANDARD_RIGHTS_REQUIRED, $__TOKEN_ASSIGN_PRIMARY, $__TOKEN_DUPLICATE, $__TOKEN_IMPERSONATE, $__TOKEN_QUERY, $__TOKEN_QUERY_SOURCE, $__TOKEN_ADJUST_PRIVILEGES, $__TOKEN_ADJUST_GROUPS, $__TOKEN_ADJUST_DEFAULT)
;~ Global Const $__TOKEN_ALL_ACCESS                        = BitOR($__TOKEN_ALL_ACCESS_P, $__TOKEN_ADJUST_SESSIONID)

;~ ;~ http://msdn.microsoft.com/library/bb530716.aspx
;~ Global Const $__SE_ASSIGNPRIMARYTOKEN_NAME              = 'SeAssignPrimaryTokenPrivilege'
;~ Global Const $__SE_AUDIT_NAME                           = 'SeAuditPrivilege'
;~ Global Const $__SE_BACKUP_NAME                          = 'SeBackupPrivilege'
;~ Global Const $__SE_CHANGE_NOTIFY_NAME                   = 'SeChangeNotifyPrivilege'
;~ Global Const $__SE_CREATE_GLOBAL_NAME                   = 'SeCreateGlobalPrivilege'
;~ Global Const $__SE_CREATE_PAGEFILE_NAME                 = 'SeCreatePagefilePrivilege'
;~ Global Const $__SE_CREATE_PERMANENT_NAME                = 'SeCreatePermanentPrivilege'
;~ Global Const $__SE_CREATE_SYMBOLIC_LINK_NAME            = 'SeCreateSymbolicLinkPrivilege'
;~ Global Const $__SE_CREATE_TOKEN_NAME                    = 'SeCreateTokenPrivilege'
;~ Global Const $__SE_DEBUG_NAME                           = 'SeDebugPrivilege'
;~ Global Const $__SE_ENABLE_DELEGATION_NAME               = 'SeEnableDelegationPrivilege'
;~ Global Const $__SE_IMPERSONATE_NAME                     = 'SeImpersonatePrivilege'
;~ Global Const $__SE_INC_BASE_PRIORITY_NAME               = 'SeIncreaseBasePriorityPrivilege'
;~ Global Const $__SE_INCREASE_QUOTA_NAME                  = 'SeIncreaseQuotaPrivilege'
;~ Global Const $__SE_INC_WORKING_SET_NAME                 = 'SeIncreaseWorkingSetPrivilege'
;~ Global Const $__SE_LOAD_DRIVER_NAME                     = 'SeLoadDriverPrivilege'
;~ Global Const $__SE_LOCK_MEMORY_NAME                     = 'SeLockMemoryPrivilege'
;~ Global Const $__SE_MACHINE_ACCOUNT_NAME                 = 'SeMachineAccountPrivilege'
;~ Global Const $__SE_MANAGE_VOLUME_NAME                   = 'SeManageVolumePrivilege'
;~ Global Const $__SE_PROF_SINGLE_PROCESS_NAME             = 'SeProfileSingleProcessPrivilege'
;~ Global Const $__SE_RELABEL_NAME                         = 'SeRelabelPrivilege'
;~ Global Const $__SE_REMOTE_SHUTDOWN_NAME                 = 'SeRemoteShutdownPrivilege'
;~ Global Const $__SE_RESTORE_NAME                         = 'SeRestorePrivilege'
;~ Global Const $__SE_SECURITY_NAME                        = 'SeSecurityPrivilege'
;~ Global Const $__SE_SHUTDOWN_NAME                        = 'SeShutdownPrivilege'
;~ Global Const $__SE_SYNC_AGENT_NAME                      = 'SeSyncAgentPrivilege'
;~ Global Const $__SE_SYSTEM_ENVIRONMENT_NAME              = 'SeSystemEnvironmentPrivilege'
;~ Global Const $__SE_SYSTEM_PROFILE_NAME                  = 'SeSystemProfilePrivilege'
;~ Global Const $__SE_SYSTEMTIME_NAME                      = 'SeSystemtimePrivilege'
;~ Global Const $__SE_TAKE_OWNERSHIP_NAME                  = 'SeTakeOwnershipPrivilege'
;~ Global Const $__SE_TCB_NAME                             = 'SeTcbPrivilege'
;~ Global Const $__SE_TIME_ZONE_NAME                       = 'SeTimeZonePrivilege'
;~ Global Const $__SE_TRUSTED_CREDMAN_ACCESS_NAME          = 'SeTrustedCredManAccessPrivilege'
;~ Global Const $__SE_UNDOCK_NAME                          = 'SeUndockPrivilege'
;~ Global Const $__SE_UNSOLICITED_INPUT_NAME               = 'SeUnsolicitedInputPrivilege'

;~ http://msdn.microsoft.com/library/ms682489.aspx
Global Const $TH32CS_SNAPHEAPLIST   = 0x01
Global Const $TH32CS_SNAPPROCESS    = 0x02
Global Const $TH32CS_SNAPTHREAD     = 0x04
Global Const $TH32CS_SNAPMODULE     = 0x08
Global Const $TH32CS_SNAPMODULE32   = 0x10
Global Const $TH32CS_INHERIT        = 0x80000000
Global Const $TH32CS_SNAPALL        = BitOR($TH32CS_SNAPHEAPLIST, $TH32CS_SNAPPROCESS, $TH32CS_SNAPTHREAD, $TH32CS_SNAPMODULE)
#endregion Constants


#region KDMemory
;~ =================================================================================================
;~  Function:       _KDMemory_OpenProcess ( $processId [, $desiredAccess [, $inheritHandle]] )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_OpenProcess($processId, $desiredAccess = $__PROCESS_ALL_ACCESS, $inheritHandle = 0)
    Local $handles[3], $callResult

    $handles[0] = $processId
    If Not ProcessExists($processId) Then Return SetError(1, 0, False)

    $handles[1] = DllOpen('Kernel32.dll')
    If $handles[1] == -1 Then Return SetError(2, 0, False)

    $callResult = DllCall($handles[1], 'ptr', 'OpenProcess', 'DWORD', $desiredAccess, 'BOOL', $inheritHandle, 'DWORD', $processId)
    If @error Then
        DllClose($handles[1])
        Return SetError(@error + 3, 0, False)
    ElseIf $callResult[0] == 0 Then
        DllClose($handles[1])
        Return SetError(9, 0, False)
    EndIf

    $handles[2] = $callResult[0]
    Return $handles
EndFunc

;~ =================================================================================================
;~  Function:       _KDMemory_CloseHandles ( $handles )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_CloseHandles($handles)
    Local $callResult

    If Not IsArray($handles) Then Return SetError(1, 0, False)

    $callResult = DllCall($handles[1], 'BOOL', 'CloseHandle', 'ptr', $handles[2])
    If @error Then
        Return SetError(@error + 1, 0, False)
    ElseIf $callResult[0] == 0 Then
        Return SetError(7, 0, False)
    EndIf

    DllClose($handles[1])
    Return True
EndFunc

;~ =================================================================================================
;~  Function:       _KDMemory_ReadProcessMemory ( $handles, $baseAddress, $type [, $offsets] )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_ReadProcessMemory($handles, $baseAddress, $type, $offsets = 0)
    Local $addressBuffer, $valueBuffer, $offsetsSize, $i, $callResult, $memoryData[2]

    If Not IsArray($handles) Then Return SetError(1, 0, False)

    $addressBuffer = DllStructCreate('ptr')
    If @error Then Return SetError(@error + 1, 0, False)
    DllStructSetData($addressBuffer, 1, $baseAddress)

    $valueBuffer = DllStructCreate($type)
    If @error Then Return SetError(@error + 5, 0, False)

    If IsArray($offsets) Then
        $offsetsSize = UBound($offsets)
    Else
        $offsetsSize = 0
    EndIf

    For $i = 0 To $offsetsSize
        If $i == $offsetsSize Then
            $callResult = DllCall($handles[1], 'BOOL', 'ReadProcessMemory', 'ptr', $handles[2], 'ptr', DllStructGetData($addressBuffer, 1), 'ptr', DllStructGetPtr($valueBuffer), 'ULONG_PTR', DllStructGetSize($valueBuffer), 'ULONG_PTR', 0)
            If @error Then
                Return SetError(@error + 20, $i, False)
            ElseIf $callResult[0] == 0 Then
                Return SetError(26, $i, False)
            EndIf
        Else
            $callResult = DllCall($handles[1], 'BOOL', 'ReadProcessMemory', 'ptr', $handles[2], 'ptr', DllStructGetData($addressBuffer, 1), 'ptr', DllStructGetPtr($addressBuffer), 'ULONG_PTR', DllStructGetSize($addressBuffer), 'ULONG_PTR', 0)
            If @error Then
                Return SetError(@error + 9, $i, False)
            ElseIf $callResult[0] == 0 Then
                Return SetError(15, $i, False)
            EndIf
        EndIf

        If $i < $offsetsSize Then
            DllStructSetData($addressBuffer, 1, DllStructGetData($addressBuffer, 1) + $offsets[$i])
            If @error Then Return SetError(@error + 15, $i, False)
        EndIf
    Next

    $memoryData[0] = DllStructGetData($addressBuffer, 1)
    $memoryData[1] = DllStructGetData($valueBuffer, 1)
    Return $memoryData
EndFunc

;~ =================================================================================================
;~  Function:       _KDMemory_ReadProcessString( $handles, $baseAddress [, $offsets [, $unicode]] )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_ReadProcessString($handles, $baseAddress, $offsets = 0, $unicode = 0)
    Local $addressBuffer, $type, $size, $valueBuffer, $offsetsSize, $i, $callResult, $memoryData[2]

    If Not IsArray($handles) Then Return SetError(1, 0, False)

    $addressBuffer = DllStructCreate('ptr')
    If @error Then Return SetError(@error + 1, 0, False)
    DllStructSetData($addressBuffer, 1, $baseAddress)

    $memoryData[1] = ''
    If $unicode <> 1 Then
        $type = 'byte'
        $size = 1
    Else
        $type = 'short'
        $size = 2
    EndIf

    $valueBuffer = DllStructCreate($type)
    If @error Then Return SetError(@error + 5, 0, False)
    $size = DllStructGetSize($valueBuffer)

    If IsArray($offsets) Then
        $offsetsSize = UBound($offsets)
    Else
        $offsetsSize = 0
    EndIf

    For $i = 0 To $offsetsSize
        If $i == $offsetsSize Then
            $count = 0
            While True
                $callResult = DllCall($handles[1], 'BOOL', 'ReadProcessMemory', 'ptr', $handles[2], 'ptr', DllStructGetData($addressBuffer, 1), 'ptr', DllStructGetPtr($valueBuffer), 'ULONG_PTR', DllStructGetSize($valueBuffer), 'ULONG_PTR', 0)
                If @error Then
                    Return SetError(@error + 20, $i + $count, False)
                ElseIf $callResult[0] == 0 Then
                    Return SetError(26, $i + $count, False)
                EndIf

                $character = DllStructGetData($valueBuffer, 1)
                If $character == 0 Then
                    ExitLoop
                Else
                    If $unicode <> 1 Then
                        $memoryData[1] &= Chr($character)
                    Else
                        $memoryData[1] &= ChrW($character)
                    EndIf
                EndIf

                DllStructSetData($addressBuffer, 1, DllStructGetData($addressBuffer, 1) + $size)
                $count += 1
            WEnd
            DllStructSetData($addressBuffer, 1, DllStructGetData($addressBuffer, 1) - ($size * $count))
        Else
            $callResult = DllCall($handles[1], 'BOOL', 'ReadProcessMemory', 'ptr', $handles[2], 'ptr', DllStructGetData($addressBuffer, 1), 'ptr', DllStructGetPtr($addressBuffer), 'ULONG_PTR', DllStructGetSize($addressBuffer), 'ULONG_PTR', 0)
            If @error Then
                Return SetError(@error + 9, $i, False)
            ElseIf $callResult[0] == 0 Then
                Return SetError(15, $i, False)
            EndIf
        EndIf

        If $i < $offsetsSize Then
            DllStructSetData($addressBuffer, 1, DllStructGetData($addressBuffer, 1) + $offsets[$i])
            If @error Then Return SetError(@error + 15, $i, False)
        EndIf
    Next

    $memoryData[0] = DllStructGetData($addressBuffer, 1)
    Return $memoryData
EndFunc

;~ =================================================================================================
;~  Function:       _KDMemory_WriteProcessMemory ( $handles, $baseAddress, $type, $value [, $offsets] )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_WriteProcessMemory($handles, $baseAddress, $type, $value, $offsets = 0)
    Local $addressBuffer, $valueBuffer, $offsetsSize, $i, $callResult

    If Not IsArray($handles) Then Return SetError(1, 0, False)

    $addressBuffer = DllStructCreate('ptr')
    If @error Then Return SetError(@error + 1, 0, False)
    DllStructSetData($addressBuffer, 1, $baseAddress)

    $valueBuffer = DllStructCreate($type)
    If @error Then Return SetError(@error + 5, 0, False)

    DllStructSetData($valueBuffer, 1, $value)
    If @error Then Return SetError(@error + 9, 0, False)

    If IsArray($offsets) Then
        $offsetsSize = UBound($offsets)
    Else
        $offsetsSize = 0
    EndIf

    For $i = 0 To $offsetsSize
        If $i == $offsetsSize Then
            $callResult = DllCall($handles[1], 'BOOL', 'WriteProcessMemory', 'ptr', $handles[2], 'ptr', DllStructGetData($addressBuffer, 1), 'ptr', DllStructGetPtr($valueBuffer), 'ULONG_PTR', DllStructGetSize($valueBuffer), 'ULONG_PTR*', 0)
            If @error Then
                Return SetError(@error + 25, $i, False)
            ElseIf $callResult[0] == 0 Then
                Return SetError(31, $i, False)
            EndIf
        Else
            $callResult = DllCall($handles[1], 'BOOL', 'ReadProcessMemory', 'ptr', $handles[2], 'ptr', DllStructGetData($addressBuffer, 1), 'ptr', DllStructGetPtr($addressBuffer), 'ULONG_PTR', DllStructGetSize($addressBuffer), 'ULONG_PTR*', 0)
            If @error Then
                Return SetError(@error + 14, $i, False)
            ElseIf $callResult[0] == 0 Then
                Return SetError(20, $i, False)
            EndIf
        EndIf

        If $i < $offsetsSize Then
            DllStructSetData($addressBuffer, 1, DllStructGetData($addressBuffer, 1) + $offsets[$i])
            If @error Then Return SetError(@error + 20, $i, False)
        EndIf
    Next

    Return DllStructGetData($addressBuffer, 1)
EndFunc

;~ =================================================================================================
;~  Function:       _KDMemory_WriteProcessString ( $handles, $baseAddress, $string [, $offsets [, $unicode]] )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_WriteProcessString($handles, $baseAddress, $string, $offsets = 0, $unicode = 0)
    Local $type, $size, $stringLength, $result

    If $unicode <> 1 Then
        $type = 'CHAR'
        $size = 1
    Else
        $type = 'WCHAR'
        $size = 2
    EndIf

    $stringLength = StringLen($string)
    $type &= '[' & $stringLength & ']'

    $result = _KDMemory_WriteProcessMemory($handles, $baseAddress, $type, $string, $offsets)
    If @error Then Return SetError(@error, @extended, False)

    _KDMemory_WriteProcessMemory($handles, $result + $size * $stringLength, 'byte', 0)
    If @error Then Return SetError(32, @extended, False)

    Return $result
EndFunc

;~ =================================================================================================
;~  Function:       _KDMemory_GetModuleBaseAddress ( $handles, $moduleName [, $caseSensitive [, $unicode]] )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_GetModuleBaseAddress($handles, $moduleName, $caseSensitive = 0, $unicode = 0)
    Local $processId, $struct, $MODULEENTRY32, $callResult, $snapshot, $moduleBaseName, $moduleBaseAddress, $skip

    If Not IsArray($handles) Then Return SetError(1, 0, False)
    If StringLen($moduleName) == 0 Then Return SetError(2, 0, False)

    $struct = _
        'DWORD dwSize;' & _
        'DWORD th32ModuleID;' & _
        'DWORD th32ProcessID;' & _
        'DWORD GlblcntUsage;' & _
        'DWORD ProccntUsage;' & _
        'ptr modBaseAddr;' & _
        'DWORD modBaseSize;' & _
        'ptr hModule;' & _
        'CHAR szModule[256];' & _
        'CHAR szExePath[260]'

    If $unicode == 1 Then $struct = StringReplace($struct, 'CHAR', 'WCHAR')
    $MODULEENTRY32 = DllStructCreate($struct)
    If @error Then Return SetError(@error + 2, 0, False)

    While True
        $callResult = DllCall($handles[1], 'ptr', 'CreateToolhelp32Snapshot', 'DWORD', BitOR($TH32CS_SNAPMODULE, $TH32CS_SNAPMODULE32), 'DWORD', $handles[0])
        If @error Then
            Return SetError(@error + 6, 0, False)
        ElseIf $callResult[0] = -1 Then
            $callResult = DllCall($handles[1], 'DWORD', 'GetLastError')
            If $callResult[0] == 0x18 Then ContinueLoop ; ERROR_BAD_LENGTH = 0x18
            Return SetError(12, $callResult[0], False)
        Else
            ExitLoop
        EndIf
    WEnd

    $snapshot = $callResult[0]
    DllStructSetData($MODULEENTRY32, 'dwSize', DllStructGetSize($MODULEENTRY32))

    $callResult = DllCall($handles[1], 'BOOL', 'Module32First', 'ptr', $snapshot, 'ptr', DllStructGetPtr($MODULEENTRY32))
    If @error Then
        Return SetError(@error + 12, 0, False)
    ElseIf $callResult[0] == 0 Then
        $callResult = DllCall($handles[1], 'DWORD', 'GetLastError')
        Return SetError(18, $callResult[0], False)
    EndIf

    $skip = False
    While True
        If Not $skip Then
            If StringCompare(DllStructGetData($MODULEENTRY32, 'szModule'), $moduleName, $caseSensitive) == 0 Then
                Return DllStructGetData($MODULEENTRY32, 'hModule')
            EndIf
            $skip = False
        EndIf

        $callResult = DllCall($handles[1], 'BOOL', 'Module32Next', 'ptr', $snapshot, 'ptr', DllStructGetPtr($MODULEENTRY32))
        If @error Then
            Return SetError(@error + 18, 0, False)
        ElseIf $callResult[0] == 0 Then
            $callResult = DllCall($handles[1], 'DWORD', 'GetLastError')
            If $callResult[0] == 0x12 Then ; ERROR_NO_MORE_FILES = 0x12
                ExitLoop
            Else
                $skip = True
            EndIf
        EndIf
    WEnd

    DllCall($handles[1], 'BOOL', 'CloseHandle', 'ptr', $snapshot)
    Return SetError(24, 0, False)
EndFunc

;~ =================================================================================================
;~  Function:       _KDMemory_FindAddress ( $handles, $pattern, $startAddress, $endAddress, ByRef $errors [, $getAll] )
;~  Author(s):      KDeluxe ( http://www.elitepvpers.com/forum/members/1219971-kdeluxe.html )
;~ =================================================================================================
Func _KDMemory_FindAddress($handles, $pattern, $startAddress, $endAddress, ByRef $errors, $getAll = 0)
    Local $size, $bytes, $errorListCount, $errorList[1][2], $addressListCount, $addressList[1], $memoryData, $offset

    If Not IsArray($handles) Then Return SetError(1, 0, False)
    If $endAddress - $startAddress <= 0 Then Return SetError(2, 0, False)

    $size = Int(StringLen($pattern) / 2) + 1
    $bytes = $size * 4

    $errorListCount = 0
    $errorList[0][0] = 0

    $addressListCount = 0
    $addressList[0] = 0

    For $address = $startAddress To $endAddress Step $size + 1
        $memoryData = _KDMemory_ReadProcessMemory($handles, $address, 'BYTE[' & $bytes & ']')
        If @error Then
            $errorListCount += 1
            ReDim $errorList[$errorListCount + 1][2]
            $errorList[$errorListCount][0] = $address
            $errorList[$errorListCount][1] = @error
            $errorList[0][0] = $errorListCount
        Else
            If StringLeft($memoryData[1], 2) = '0x' Then
                $memoryData[1] = StringTrimLeft($memoryData[1], 2)
            EndIf

            $pattern = StringRegExpReplace($pattern, '[^.0-9a-fA-F]', '')
            StringRegExp($memoryData[1], $pattern, 1)
            If Not @error Then
                $offset = Round((@extended - StringLen($pattern) - 2) / 2, 0)

                $addressListCount += 1
                ReDim $addressList[$addressListCount + 1]
                $addressList[$addressListCount] = $address + $offset
                $addressList[0] = $addressListCount

                If $getAll <> 1 Then ExitLoop
            EndIf
        EndIf
    Next

    $errors = $errorList
    If $errorListCount > 0 Then SetExtended(1)

    Return $addressList
EndFunc
#endregion KDMemory