
Partial Class CEOx1Day
    Inherits System.Web.UI.Page
    Dim dvReportTypes As System.Data.DataView
    Dim sFolderName As String
    Dim sFileNames(0) As String

    Protected Sub btnGet_Click(sender As Object, e As System.EventArgs) Handles btnGet.Click
        Dim sSql As String, dv1 As System.Data.DataView

        If Request.QueryString("ASsgnID") Is Nothing Or Request.QueryString("AssgnID") = "" Then
            Me.Message.Text = "Assignment ID not specified."
            Exit Sub
        End If
        sSql = "SELECT [CandidateID], [CandidateName], FirstName, LastName, EmailAddress, [CEox1day_EmailDate], LanguageID, [HoganUserName], HoganUserPassword, AssgnTypeID, AssgnTypeName, AdminEmailAddress FROM [qryAssgnCandidates] "

        sSql = sSql & " where AssgnID=" & Request.QueryString("AssgnID")

        If Me.LastName.Text <> "" Then
            sSql = sSql & " and LastName Like '%" & Me.LastName.Text & "%'"
        End If

        If Me.SentStatus.SelectedValue = "Sent" Then
            sSql = sSql & " and CEOx1day_EmailDate is not null"
        ElseIf Me.SentStatus.SelectedValue = "Unsent" Then
            sSql = sSql & " and CEOx1day_EmailDate is null"
        End If

        sSql = sSql & " order by LastName, FirstName"

        dv1 = CF.DataView_Get(sSql)
        Me.tabA.DataSource = dv1
        Me.tabA.DataBind()
    End Sub

    Protected Sub tabA_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles tabA.RowCommand
        If e.CommandName = "EmailReports" Then
            Candidates_Email()
        End If
    End Sub

    Protected Sub tabA_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabA.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
        Else
            Exit Sub
        End If
        Reports_Show(e)

    End Sub

    Sub Reports_Show(e As System.Web.UI.WebControls.GridViewRowEventArgs)
        Dim i1 As Integer, hl1 As HyperLink, L1 As Label, sSrcFileName As String
        Dim sTargetFileName As String, f1 As System.IO.FileInfo, L2 As Label
       
        If sFolderName = "" Then
            sFolderName = (ConfigurationManager.AppSettings("ReportsFolderName"))
            sFolderName = Server.MapPath(sFolderName)
            Trace.Warn((sFolderName))
        End If

        'Show Report Links
        If e.Row.RowType = DataControlRowType.DataRow Then
            L1 = e.Row.FindControl("HoganUserName")
            If L1.Text = "" Then GoTo Folders_Done

            Trace.Warn(sFolderName)
            sFileNames = System.IO.Directory.GetFiles((sFolderName), L1.Text & "*.pdf")
            Trace.Warn(L1.Text & " " & UBound(sFileNames))
            If UBound(sFileNames) = -1 Then GoTo Folders_Done


            For i1 = 0 To UBound(sFileNames)
                Trace.Warn(sFileNames(i1))
                Trace.Warn("Src=" & sFileNames(i1))
                sSrcFileName = CF.FileName_Get(sFileNames(i1))
                sTargetFileName = Replace(sFileNames(i1), sFolderName, Server.MapPath(ConfigurationManager.AppSettings("ReportsFolderName")))
                Trace.Warn("Tgt=" & sTargetFileName)
                f1 = New System.IO.FileInfo(sTargetFileName)
                If f1.Exists Then
                    Trace.Warn("Target file exists.")
                Else
                    Trace.Warn("Target file does not exist.")
                    System.IO.File.Copy(sFileNames(i1), Server.MapPath(ConfigurationManager.AppSettings("ReportsFolderName")) & "/" & sSrcFileName, True)
                End If

                L2 = New Label
                L2.Text = i1 + 1 & ". "
                e.Row.Cells(3).Controls.Add(L2)

                hl1 = New HyperLink
                e.Row.Cells(3).Controls.Add(hl1)
                Trace.Warn(sSrcFileName)
                hl1.Text = ReportType_Get(sSrcFileName) & "<br>"
                hl1.NavigateUrl = ConfigurationManager.AppSettings("ReportsFolderName") & "/" & sSrcFileName
                hl1.Target = "new"

            Next
        End If

Folders_Done:
        
    End Sub


    Function ReportType_Get(ByVal sFileName As String) As String
        Dim i1 As Integer, sSplit() As String

        If dvReportTypes Is Nothing Then
            dvReportTypes = CF.DataView_Get("Select ReportTypeID, ReportTypeName from ReportTypes order by ReportTypeName")
        End If

        sSplit = Split(sFileName, "-")
        For i1 = 0 To dvReportTypes.Table.Rows.Count - 1
            If dvReportTypes.Table.Rows(i1)("ReportTypeID") = sSplit(1) Then
                ReportType_Get = dvReportTypes.Table.Rows(i1)("ReportTypeName")
                Exit Function
            End If
        Next

        ReportType_Get = sSplit(1)
    End Function


    Sub Candidates_Email()
        Dim gr As GridViewRow, chk1 As CheckBox, L1 As Label
        Dim sSubject As String, sMessage As String, L2 As Label
        Dim sSql As String, i1 As Integer, L3 As Label
        Dim iCount As Integer, dvE As System.Data.DataView

        dvE = CF.DataView_Get("Select LanguageID, RptEmailSubject, RptEmailMessage from Languages order by LanguageID")
        iCount = 0
        For Each gr In Me.tabA.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                chk1 = gr.FindControl("SendEmail")
                L1 = gr.FindControl("HoganUserName")
                L3 = gr.FindControl("LanguageID")
                If chk1.Checked Then
                    For i1 = 0 To dvE.Table.Rows.Count - 1
                        If dvE.Table.Rows(i1)("LanguageID") = L3.Text Then
                            sSubject = CF.NullToString(dvE.Table.Rows(i1)("RptEmailSubject"))
                            sMessage = CF.NullToString(dvE.Table.Rows(i1)("RptEmailMessage"))
                            'Trace.Warn("Message=" & sMessage)
                            Exit For
                        End If
                    Next

                    'Substitutions
                    sMessage = Replace(sMessage, "|FirstName|", gr.Cells(1).Text)
                    sMessage = Replace(sMessage, "|LastName|", gr.Cells(0).Text)


                    sMessage = Replace(sMessage, vbCrLf, vbCrLf & "<br>")
                    Trace.Warn(sMessage)
                    PDFs_List(L1.Text)
                     If sFileNames.Length > 0 Then
                        L1 = gr.FindControl("EmailAddress")
                        L2 = gr.FindControl("AdminEmailAddress")
                        CF.Email_SendAttachment(L2.Text, L1.Text, "", sSubject, sMessage, sFileNames(0))

                        L2 = gr.FindControl("CandidateID")
                        sSql = "Update Candidates Set CEOx1day_EmailDate=getDate() where CandidateID=" & L2.Text
                        Trace.Warn(sSql)
                        CF.Runquery(sSql)
                        iCount = iCount + 1
                    End If
                End If
            End If
        Next

        If iCount > 0 Then
            Me.Message.Text = iCount & " message(s) sent"
            Exit Sub
        End If
    End Sub

    Sub PDFs_List(sHoganUserName As String)
        Dim i1 As Integer
        If sFolderName = "" Then
            sFolderName = (ConfigurationManager.AppSettings("ReportsFolderName"))
            sFolderName = Server.MapPath(sFolderName)
            Trace.Warn((sFolderName))
        End If
        sFileNames = System.IO.Directory.GetFiles((sFolderName), sHoganUserName & "*.pdf")
        For i1 = 0 To UBound(sFileNames)
            Trace.Warn(sFileNames(i1))
        Next


    End Sub
End Class
