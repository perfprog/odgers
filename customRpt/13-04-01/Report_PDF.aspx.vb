Imports WebSupergoo.ABCpdf9
Partial Class MakePDF
    Inherits System.Web.UI.Page
    Dim theDoc, x1
    'The current version is in the Import class - this one is obsolete


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim aRecordID() As String, i1 As Integer, sWhich As String

        XSettings.License = "810-031-225-276-6105-881"
        Trace.Warn("License=" & XSettings.License)

        theDoc = New Doc
        sWhich = ""
        If Request.QueryString("ReportType") <> "" Then sWhich = Request.QueryString("ReportType").ToString

        If Request.QueryString("HoganCode") <> "" Then
            aRecordID = Split(Request.QueryString("HoganCode"), ",")
            For i1 = 0 To UBound(aRecordID)
                Trace.Warn(aRecordID(i1))
                'Call PDF_Generate(aRecordID(i1))
                Import1.PDF_Generate(aRecordID(i1), sWhich)
            Next
        End If

        theDoc.Dispose()
        theDoc = Nothing
    End Sub

    Sub PDF_Generate_Old(ByVal iCandidateID As Long)
        Dim theURL, theID, sParticipantName As String, iStart As Integer
        Dim i1 As Integer, sReportFileName As String, iPageNo As Integer
        Dim sConfidential As String, sFileName As String
        Dim sSql As String, dvP As System.Data.DataView, sWhich As String

        Trace.Warn(iCandidateID)

        dvP = CF.DataView_Get("Select FirstName, LastName, HoganUserName, ob_confidential1, ob_confidential2, AssgnTypeID  from qryPDFSrc where CandidateID=" & iCandidateID)
        sParticipantName = dvP.Table.Rows(0)("FirstName") & " " & dvP.Table.Rows(0)("LastName")

        theDoc.Clear()

        theURL = ConfigurationManager.AppSettings("AppRoot")
        sWhich = ""
        If Request.QueryString("ReportType") <> "" Then sWhich = Request.QueryString("ReportType").ToString
        If sWhich = "Appendix" Then
            theURL = theURL & ConfigurationManager.AppSettings("ReportURL_appendix")
            iStart = 1
        Else
            theURL = theURL & ConfigurationManager.AppSettings("ReportURL_benchmark")
            iStart = 2
        End If

        theURL = theURL & "?CandidateID=" & iCandidateID
        theURL = theURL & "&A=" & Request.QueryString("A") & Today.Second
        Trace.Warn(theURL)


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
            theDoc.AddHTML("<font color=""#003d79"" font-family=""Lucida Sans"" font-weight=""Demibold Roman"" size=""2"">" & iPageNo & "</font>")

            'Odgers name
            theDoc.PageNumber = i1
            theDoc.HPos = 0.0
            theDoc.VPos = 1.0
            theDoc.Rect.Position(460, 15)
            theDoc.Rect.Width = 100
            theDoc.Rect.Height = 15
            'theDoc.FrameRect()
            theDoc.AddHTML("<font font-family=""Lucida Sans"" font-weight=""Demibold Roman"" size=""2"">" & "Odgers Berndtson" & "</font>")
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
                theDoc.AddHTML(sConfidential)

            Next
        End If


        For i1 = 1 To theDoc.PageCount
            theDoc.PageNumber = i1
            theDoc.Flatten()
        Next



        'Save File
        If sWhich <> "Appendix" Then sWhich = ""
        sReportFileName = AF.fsReportFileName(dvP.Table.Rows(0)("HoganUserName"), dvP.Table.Rows(0)("AssgnTypeID"), sWhich)
        sFileName = Server.MapPath("../HoganReports/" & sReportFileName)
        'sFileName = Replace(sFileName, "default.aspx", sReportFileName)
        Trace.Warn(sFileName)
        theDoc.Save(sFileName)

        'Set Date report generated in the Q Participants table
        sSql = "Update candidates set DateLFGenerated=getDate() where CandidateID=" & iCandidateID
        CF.Runquery(sSql)

        'Send Email
        Call CF.Email_Send("odgers@perfprog.com", "", "", "Odgers Report Generated", sReportFileName)
    End Sub
End Class
