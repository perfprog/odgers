Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Web.HttpContext
Imports WebSupergoo.ABCpdf9
Imports PPIExceptionHelper

Public Class Import1

    Public Shared Function FieldName_Get(ByVal sFieldName As String, ByVal dvF As System.Data.DataView) As String
        Dim i1 As Integer

        For i1 = 0 To dvF.Table.Rows.Count - 1
            If UCase(dvF.Table.Rows(i1)("ColumnName")) = UCase(sFieldName) Then
                FieldName_Get = dvF.Table.Rows(i1)("CanFieldName")
                Exit Function
            End If
        Next

        FieldName_Get = ""
        ReportLog.Debug_Show("Field not found >>>: " & sFieldName)
    End Function

    Public Shared Sub File_Process(ByVal sFileName As String)
        Dim i1 As Integer, j1 As Integer
        Dim sSql As String, dvF As System.Data.DataView, dvC As System.Data.DataView
        Dim conn As System.Data.Odbc.OdbcConnection
        Dim dt As New System.Data.DataTable
        Dim da As System.Data.Odbc.OdbcDataAdapter
        Dim connectionString As String, sFieldName As String, sHoganCode As String

        'Open dv for gettign CanFieldNames
        dvF = CF.DataView_Get("Select ColumnName, CanFieldName from ImportSpec where CanFieldName is not Null and CanFieldName <>'ignore' order by ColumnName")

        'Open file
        ReportLog.Debug_Show(sFileName)
        connectionString = "Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=" + "c:\inetpub\wwwroot\Odgers_live\HoganReports" + ";"
        'connectionString = "Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=" + "f:\crap\ann\Odgers_live\HoganReports" + ";"
        conn = New Odbc.OdbcConnection(connectionString)
        da = New System.Data.Odbc.OdbcDataAdapter("select * from [" + CF.FileName_Get(sFileName) + "]", conn)
        da.Fill(dt)
        ReportLog.Debug_Show("ROWS=" & dt.Rows.Count)

        'Process data rows - one per candidate
        For j1 = 0 To dt.Rows.Count - 1
            ReportLog.Debug_Show("================================================================")
            sSql = "FileName='" & Replace(CF.FileName_Get(sFileName), "'", "''") & "'"
            For i1 = 0 To dt.Columns.Count - 1
                ReportLog.Debug_Show(dt.Columns(i1).ColumnName & "=" & dt.Rows(j1)(dt.Columns(i1).ColumnName))
                sFieldName = Import1.FieldName_Get(dt.Columns(i1).ColumnName, dvF)
                If sFieldName <> "" Then
                    If sFieldName = "UserName" Then
                        sHoganCode = dt.Rows(j1)(dt.Columns(i1).ColumnName)

                        'Find Candidate record here

                    ElseIf sFieldName = "Gender" Then '8/1/12: gender - use Hogan value only if it is not blank
                        If CF.NullToString(dt.Rows(j1)(dt.Columns(i1).ColumnName)) = "" Then
                        Else
                            sSql = sSql & ", " & sFieldName & "='" & dt.Rows(j1)(dt.Columns(i1).ColumnName) & "'"
                        End If
                    ElseIf CF.NullToString(dt.Rows(j1)(dt.Columns(i1).ColumnName)) = "" Then
                        sSql = sSql & ", " & sFieldName & "=Null"
                    Else
                        sSql = sSql & ", " & sFieldName & "='" & dt.Rows(j1)(dt.Columns(i1).ColumnName) & "'"
                    End If
                Else
                    'ReportLog.Debug_Show("Not found " & dt.Columns(i1).ColumnName)
                End If
            Next
            ReportLog.Debug_Show(sSql)
            sSql = "Update Candidates set " & sSql & " where CandidateID="
            sSql = sSql & "ISNULL((select top 1 CandidateID from HoganCodes where UserName='" & sHoganCode & "'), 0)"
            ReportLog.Debug_Show(sSql)

            CF.Runquery(sSql)

            '''' Insert Generate report logic here
            sSql = "select top 1 dbo.Hogan_hasAllData(CandidateID) as GenerateRpt from qryAssgncandidates where IsOdgersCustom=1 and HoganUserName='" & sHoganCode & "'"
            ReportLog.Debug_Show(sSql)
            dvC = CF.DataView_Get(sSql)
            If dvC.Table.Rows.Count = 0 Then
                'This is not a benchmark candidate
                ReportLog.Debug_Show("SKIPPED1 " & sHoganCode)
            ElseIf dvC.Table.Rows(0)("GenerateRpt") = "false" Then
                ReportLog.Debug_Show("SKIPPED2 " & sHoganCode)
                'Send "incomplete data" email message here
                Dim sLogResult As String = PPIExceptionTools.LogEvent(String.Format("Odgers - Incomplete data received. Hogan Code = {0}", sHoganCode))
                'CF.Email_Send("surveys@performanceprograms.com", "ann@performanceprograms.com", "", "Odgers - Incomplete data received", "Hogan Code=" & sHoganCode)
            ElseIf dvC.Table.Rows(0)("GenerateRpt") = "true" Then
                ReportLog.Debug_Show("PROCESSING " & sHoganCode)
                Import1.PDF_Generate(sHoganCode, "")
                Import1.PDF_Generate(sHoganCode, "Appendix")
            End If


        Next
    End Sub


    Public Shared Sub Files_Scan(ByVal sFolderName As String)
        'Dim sFolderName As String
        Dim files() As System.IO.FileSystemInfo, sSql As String, sNewName As String
        Dim di As System.IO.DirectoryInfo, i1 As Integer
        Dim dv As System.Data.DataView
        Dim dStartdate As Date

        'Get StartDate
        dv = CF.DataView_Get("Select Top 1 DateProcessed as StartDate from ImportLog order by AutoID Desc")
        dStartdate = dv.Table.Rows(0)("StartDate")
        dStartdate = dStartdate.AddSeconds(1)
        ReportLog.Debug_Show(dStartdate)

        'Get Files
        di = New System.IO.DirectoryInfo(sFolderName)
        files = di.GetFileSystemInfos("*.csv")

        Array.Sort(files, New ReportLog.DateComparer)

        For i1 = 0 To files.Length - 1
            If DateDiff(DateInterval.Second, dStartdate, files(i1).LastWriteTime) > 0 Then
                ReportLog.Debug_Show(files(i1).FullName & ">>" & files(i1).LastWriteTime)

                'rename file
                dStartdate = files(i1).LastWriteTime
                ReportLog.Debug_Show(dStartdate & "===>" & dStartdate.Hour)
                sNewName = Replace(files(i1).FullName, ".csv", "_" & dStartdate.Hour & ".csv")
                System.IO.File.Move(files(i1).FullName, sNewName)


                'Process the file
                If dv.Table.Rows.Count <> 0 Then
                    Import1.File_Process(sNewName)
                    sSql = "Insert into ImportLog(FileName) Select "
                    sSql = sSql & "'" & Replace(CF.FileName_Get(sNewName), "'", "''") & "'"
                    ReportLog.Debug_Show(sSql)
                    CF.Runquery(sSql)
                End If
            Else
                'CF.Email_Send("odgers@perfprog.com", "", "", "No new Odgers data files were found", "-- end--")
                Dim sLogResult As String = PPIExceptionTools.LogEvent("No new Odgers data files were found")
                Exit Sub
            End If
        Next
    End Sub

    Public Shared Sub PDF_Generate(ByVal sHoganCode As String, sWhich As String)
        Dim theURL, theID, sParticipantName As String
        Dim i1 As Integer, sReportFileName As String, iPageNo As Integer
        Dim sFileName As String, iStart As Integer, sConfidential As String
        Dim sSql As String, dvP As System.Data.DataView
        Dim theDoc As WebSupergoo.ABCpdf9.Doc

        Dim a1 As AssgnType

        'XSettings.License = "810-031-225-276-6105-881"
        ReportLog.Debug_Show(sHoganCode)
        dvP = CF.DataView_Get("Select FirstName, LastName, HoganUserName, LanguageID, ob_confidential1, ob_confidential2, AssgnTypeID, CandidateID  from qryPDFSrc where HoganUserName='" & sHoganCode & "'")
        sParticipantName = dvP.Table.Rows(0)("FirstName") & " " & dvP.Table.Rows(0)("LastName")
        a1 = New AssgnType(dvP.Table.Rows(0)("AssgnTypeID"))

        theDoc = New Doc
        theDoc.EmbedFont("Lucida Sans")

        theURL = ConfigurationManager.AppSettings("AppRoot")
        If sWhich = "Appendix" Then
            theURL = theURL & ConfigurationManager.AppSettings("ReportURL_appendix")
            iStart = 1
            If dvP.Table.Rows(0)("LanguageID") = 6 Then
                'german
                theURL = Replace(theURL, ".aspx", "_long.aspx")
            Else
                theURL = Replace(theURL, ".aspx", "_short.aspx")
            End If
        Else
            If a1.IsHBC() Then
                theURL = theURL & ConfigurationManager.AppSettings("ReportURL_HBC")
                iStart = 2
            Else
                theURL = theURL & ConfigurationManager.AppSettings("ReportURL_benchmark")
                iStart = 2
            End If

        End If

        theURL = theURL & "?CandidateID=" & dvP.Table.Rows(0)("CandidateID")
        theURL = theURL & "&A=" & Import1.Random_Get()
        ReportLog.Debug_Show(theURL)


        'Add Pages
        theDoc.Rect.Position(10, 30) 'was 40,40
        theDoc.Rect.Width = 592 'was 530
        theDoc.Rect.Height = 740 'was 700
        'theDoc.FrameRect()

        theID = theDoc.AddImageUrl(theURL, True, 0, True)
        Do
            If theDoc.GetInfo(theID, "Truncated") <> "1" Then Exit Do
            theDoc.Page = theDoc.AddPage()
            'theDoc.FrameRect()
            theID = theDoc.AddImageToChain(theID)
        Loop

        'Add Page number and logo in footer
        For i1 = iStart To theDoc.PageCount
            'page number
            theDoc.PageNumber = i1
            iPageNo = iPageNo + 1
            theDoc.HPos = 0.0
            theDoc.VPos = 1.0
            theDoc.Rect.Position(560, 15)
            theDoc.Rect.Width = 20
            theDoc.Rect.Height = 15
            'theDoc.Framerect()
            theDoc.AddHtml("<font color=""#003d79"" font-family=""Lucida Sans"" font-weight=""Demibold Roman"" size=""2"">" & iPageNo & "</font>")

            'Odgers name
            theDoc.PageNumber = i1
            theDoc.HPos = 0.0
            theDoc.VPos = 1.0
            theDoc.Rect.Position(460, 15)
            theDoc.Rect.Width = 100
            theDoc.Rect.Height = 15
            'theDoc.FrameRect()
            theDoc.AddHtml("<font font-family=""Lucida Sans"" font-weight=""Demibold Roman"" size=""2"">" & "Odgers Berndtson" & "</font>")
        Next

        'Add Confidentiality text on Page 2 only for the main report (not appendix)
        If sWhich <> "Appendix" Then
            sConfidential = "<font color=""#003d79"" font-family=""Lucida Sans"" font-weight=""Demibold Roman"" size=""2"">" & dvP.Table.Rows(0)("ob_confidential1") & "</font>"
            sConfidential = sConfidential & "<br><br>"
            sConfidential = sConfidential & "<font color=""#BBBBBB"" font-family=""Lucida Sans"" font-weight=""Demibold Roman"" size=""1"">" & dvP.Table.Rows(0)("ob_confidential2") & "</font>"

            For i1 = 2 To 2
                theDoc.PageNumber = i1
                theDoc.HPos = 0.0
                theDoc.VPos = 1.0
                theDoc.Rect.Position(80, 15)
                theDoc.Rect.Width = 200
                theDoc.Rect.Height = 50
                'theDoc.Framerect()
                theDoc.AddHtml(sConfidential)

            Next
        End If


        For i1 = 1 To theDoc.PageCount
            theDoc.PageNumber = i1
            theDoc.Flatten()
        Next



        'Save File
        If sWhich = "Appendix" Then
            sWhich = "OBAppendix"
        Else
            sWhich = a1.RptName
        End If
        sFileName = AF.fsReportFileName(dvP.Table.Rows(0)("HoganUserName"), sWhich)
        ReportLog.Debug_Show(sFileName)
        theDoc.Save(sFileName)

        'Set Date report generated in the Q Participants table
        sSql = "Update candidates set DateLFGenerated=getDate() where DateLFGenerated is null and CandidateID=" & dvP.Table.Rows(0)("CandidateID")
        CF.Runquery(sSql)

        'Send Email / logging
        Dim sLogResult As String = PPIExceptionTools.LogEvent(String.Format("Odgers Report Generated. Filename: {0}", sFileName))
        'Call CF.Email_Send("odgers@perfprog.com", "", "", "Odgers Report Generated", sFileName)

        theDoc.Dispose()
        theDoc = Nothing
    End Sub

    Public Shared Function Random_Get() As Long
        Dim r1 As New Random

        Random_Get = r1.Next
    End Function
End Class
