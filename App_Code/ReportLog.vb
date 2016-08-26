Imports Microsoft.VisualBasic
Imports System.Data
Imports PPIExceptionHelper

Public Class ReportLog
    Public Shared Sub Files_Scan(sFolderName As String)
        'Dim sFolderName As String
        Dim files() As System.IO.FileSystemInfo, sSql As String
        Dim di As System.IO.DirectoryInfo, i1 As Integer
        Dim dv As System.Data.DataView, sMessage As String
        Dim dStartdate As Date, bSent As Boolean
        Dim sLogResult As String

        'CF.LogIt("ReportLog.Files_Scan", "Scanning " & sFolderName, System.Diagnostics.EventLogEntryType.Information)
        'sLogResult = PPIExceptionTools.LogEvent("Scanning " & sFolderName)

        'Get StartDate
        dv = CF.DataView_Get("Select Top 1 EmailDate as StartDate from ReportLog order by RecordID Desc")
        dStartdate = dv.Table.Rows(0)("StartDate")
        dStartdate = dStartdate.AddSeconds(1)
        'CF.LogIt("ReportLog.Files_Scan", "dStartdate= " & dStartdate, System.Diagnostics.EventLogEntryType.Information)
        'sLogResult = PPIExceptionTools.LogEvent("dStartdate= " & dStartdate)

        'Get Files
        di = New System.IO.DirectoryInfo(sFolderName)
        files = di.GetFileSystemInfos("*.pdf")
        'sLogResult = PPIExceptionTools.LogEvent("Total number of report files found = " & files.Length.ToString())
        'CF.LogIt("ReportLog.Files_Scan", "Total number of report files found = " & files.Length.ToString(), System.Diagnostics.EventLogEntryType.Information)

        Array.Sort(files, New DateComparer)
        bSent = False
        Dim newfiles As Integer = 0
        For i1 = 0 To files.Length - 1
            If DateDiff(DateInterval.Second, dStartdate, files(i1).LastWriteTime) > 10 Then 'was 0

                newfiles += 1
                'CF.LogIt("ReportLog.Files_Scan", files(i1).FullName & ">>" & files(i1).LastWriteTime, System.Diagnostics.EventLogEntryType.Information)
                'sLogResult = PPIExceptionTools.LogEvent(files(i1).FullName & ">>" & files(i1).LastWriteTime.ToString())

                'Get Email Address
                dv = NotifyInfo_Get(files(i1).FullName)

                'Make an entry in the ReportLog and Send email message
                If dv.Table.Rows.Count <> 0 Then
                    sSql = "Insert into ReportLog(ReportFileName, ReportDate, EmailAddress) Select"
                    sSql = sSql & "'" & Replace(CF.FileName_Get(files(i1).FullName), "'", "''") & "'"
                    sSql = sSql & ", '" & files(i1).LastWriteTime & "'"
                    sSql = sSql & ", '" & Replace(CF.NullToString(dv.Table.Rows(0)("AdminEmailAddress")), "'", "''") & "'"
                    Debug_Show(sSql)
                    CF.Runquery(sSql)

                    sMessage = "Assignment: " & dv.Table.Rows(0)("ClientName") & "-" & dv.Table.Rows(0)("AssgnDesc")
                    sMessage &= "<br>" & "Report Type: " & ReportLog.ReportType_Get(CF.FileName_Get(files(i1).FullName))
                    sMessage &= "<br>" & "Candidate: " & dv.Table.Rows(0)("CandidateName")
                    sMessage &= "<br>" & "Office: " & dv.Table.Rows(0)("OfficeName")
                    sMessage &= "<br>" & "-- End --"
                    Debug_Show(sMessage)

                    sSql = "Select * from Reportlog where ReportFileName = '"
                    sSql = sSql & Replace(CF.FileName_Get(files(i1).FullName), "'", "''")
                    sSql = sSql & "'and CONVERT(DATE, ReportDate) = CONVERT(DATE, GETDATE())"
                    Dim HasReport As DataView = CF.DataView_Get(sSql)
                    If HasReport.Count > 1 Then
                        'there is a report already created today for the Report name do nothing 
                        'sLogResult = PPIExceptionTools.LogEvent("There is a report already created today for the Report " & files(i1).FullName)
                        'CF.LogIt("ReportLog.Files_Scan",
                        '        "There is a report already created today for the Report " & files(i1).FullName,
                        '       System.Diagnostics.EventLogEntryType.Warning)
                    Else
                        CF.Email_SendAttachment(ConfigurationManager.AppSettings("sender"), dv.Table.Rows(0)("AdminEmailAddress"), "", "Report Generated for " & dv.Table.Rows(0)("CandidateName"), sMessage, files(i1).FullName)
                        'CF.Email_Send(ConfigurationManager.AppSettings("sender"), dv.Table.Rows(0)("AdminEmailAddress"), "", "Report Generated for " & dv.Table.Rows(0)("CandidateName"), sMessage, files(i1).FullName)
                        bSent = True
                    End If

                End If
            End If
        Next

        'sLogResult = PPIExceptionTools.LogEvent("Total number of NEW report files found = " & newfiles)
        'CF.LogIt("ReportLog.Files_Scan", "Total number of NEW report files found = " & newfiles, System.Diagnostics.EventLogEntryType.Information)

        If Not bSent Then
            'sLogResult = PPIExceptionTools.LogEvent("No reports sent")
            'CF.LogIt("ReportLog.Files_Scan", "No reports sent", System.Diagnostics.EventLogEntryType.Information)
            Exit Sub
        End If
    End Sub

    Public Shared Function ReportType_Get(ByVal sFileName As String) As String
        Dim i1 As Integer, sSplit() As String, dvReportTypes As System.Data.DataView

        dvReportTypes = CF.DataView_Get("Select ReportTypeID, ReportTypeName from ReportTypes order by ReportTypeName")

        sSplit = Split(sFileName, "-")
        For i1 = 0 To dvReportTypes.Table.Rows.Count - 1
            If dvReportTypes.Table.Rows(i1)("ReportTypeID") = sSplit(1) Then
                ReportType_Get = dvReportTypes.Table.Rows(i1)("ReportTypeName")
                Exit Function
            End If
        Next

        ReportType_Get = sSplit(1)
    End Function

    Public Shared Sub Debug_Show(ByVal s1 As String)
        System.Web.HttpContext.Current.Trace.Warn(s1)
    End Sub


    Public Shared Function NotifyInfo_Get(ByVal sFileName As String) As System.Data.DataView
        Dim sJustFileName As String, sHoganUserName As String

        sJustFileName = CF.FileName_Get(sFileName)
        If InStr(sJustFileName, "-") = 0 Then
            NotifyInfo_Get = CF.DataView_Get("Select Top 1 LanguageID from Languages where LanguageID=-1")
        Else
            sHoganUserName = Left(sJustFileName, InStr(sJustFileName, "-") - 1)
            NotifyInfo_Get = CF.DataView_Get("Select Top 1 AdminEmailAddress, AssgnName, CandidateName, officeName, CLientName, AssgnDesc from qryAssgnCandidates where HoganUserName='" & Replace(sHoganUserName, "'", "''") & "' order by EmailDate Desc")
        End If

    End Function

    Public Class DateComparer
        Implements System.Collections.IComparer

        Public Function Compare(ByVal info1 As Object, ByVal info2 As Object) As Integer Implements System.Collections.IComparer.Compare
            Dim FileInfo1 As System.IO.FileInfo = DirectCast(info1, System.IO.FileInfo)
            Dim FileInfo2 As System.IO.FileInfo = DirectCast(info2, System.IO.FileInfo)

            Dim Date1 As DateTime = FileInfo1.LastWriteTime
            Dim Date2 As DateTime = FileInfo2.LastWriteTime

            If Date1 > Date2 Then Return -1
            If Date1 < Date2 Then Return 1
            Return 0
        End Function
    End Class
End Class
