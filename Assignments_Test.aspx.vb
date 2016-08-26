Imports BasicFrame

Partial Class Assignments
    Inherits System.Web.UI.Page
    Dim sFolderName As String, sFileNames() As String
    Dim dvReportTypes As System.Data.DataView
    Dim IsNew As Boolean

    Protected Sub tabList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tabList.SelectedIndexChanged
        Trace.Warn("A")
        Me.tabDetail.ChangeMode(DetailsViewMode.Edit)
        Me.tabDetail.Visible = True
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Trace.Warn("B")
        Me.tabDetail.ChangeMode(DetailsViewMode.Insert)
        Me.tabList.SelectedIndex = -1
        IsNew = True
    End Sub


    Protected Sub tabDetail_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewDeletedEventArgs) Handles tabDetail.ItemDeleted
        Trace.Warn("C")

        Me.tabList.DataBind()
        Me.tabList.SelectedIndex = 0

        'Not currently deleting Candidates associated with search
    End Sub

    Protected Sub tabDetail_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertedEventArgs) Handles tabDetail.ItemInserted
        Trace.Warn("D")

        Me.tabList.DataBind()
        e.KeepInInsertMode = False
        Me.tabList.SelectedIndex = 0

    End Sub

    Protected Sub tabDetail_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles tabDetail.ItemInserting
        Trace.Warn("E")
        ' This check not needed
        Exit Sub


        'Make sure the group code is unique
        Dim dv1 As System.Data.DataView
        dv1 = CF.DataView_Get("Select AssgnDesc from Assignments where AssgnDesc='" & Replace(e.Values("AssgnDesc"), "'", "''") & "'")
        If dv1.Table.Rows.Count > 0 Then
            e.Cancel = True
            Me.Message.Text = "This Assignment Name is in use. Please try again."
            Exit Sub
        End If

        Trace.Warn(e.Values("StartDate"))
    End Sub

    Protected Sub tabCandidates_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles tabCandidates.RowCommand
        Trace.Warn(e.CommandName)
        If e.CommandName = "Email" Then
            Candidates_Email()
        ElseIf e.CommandName = "UpdateC" Then
            Candidates_Update()
        ElseIf e.CommandName = "DeleteC" Then
            Candidates_Delete()
        End If
    End Sub

    Sub Candidates_Email()
        Dim gr As GridViewRow, chk1 As CheckBox, L1 As Label, dd1 As DropDownList
        Dim sSubject As String, sMessage As String, L2 As Label, sParticipantName As String
        Dim bdp1 As BasicFrame.WebControls.BDPLite, sSql As String, i1 As Integer
        Dim TAdminEmailAddress As TextBox, iCount As Integer, sScript As String
        Dim sCultureInit As String

        TAdminEmailAddress = Me.tabDetail.FindControl("AdminEmailAddress")
        Trace.Warn(TAdminEmailAddress.Text)
        Trace.Warn("Assgn ID=" & Me.tabDetail.SelectedValue)


        Dim dvE As System.Data.DataView
        'dvE = Me.rsLang.Select(DataSourceSelectArguments.Empty)
        dvE = CF.DataView_Get("Select Top 1 EmailSubject, EmailMessage, CultureInit from Assgn_Email where AssgnID=" & Me.tabDetail.SelectedValue)

        sCultureInit = "en-US"
        iCount = 0
        For Each gr In Me.tabCandidates.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                chk1 = gr.FindControl("SendEmail")
                L1 = gr.FindControl("EmailAddress")
                dd1 = gr.FindControl("LanguageID")
                If chk1.Checked Then
                    iCount = iCount + 1
                    'For i1 = 0 To dvE.Table.Rows.Count - 1
                    'If dvE.Table.Rows(i1)("LanguageID") = dd1.SelectedValue Then
                    i1 = 0
                    sSubject = CF.NullToString(dvE.Table.Rows(i1)("EmailSubject"))
                    sMessage = CF.NullToString(dvE.Table.Rows(i1)("EmailMessage"))
                    sCultureInit = CF.NullToString(dvE.Table.Rows(i1)("CultureInit"))
                    'Trace.Warn("Message=" & sMessage)
                    'Exit For
                    'End If
                    'Next

                    'Substitutions
                    L2 = gr.FindControl("FirstName")
                    sMessage = Replace(sMessage, "|FirstName|", L2.Text)

                    L2 = gr.FindControl("LastName")
                    sMessage = Replace(sMessage, "|LastName|", L2.Text)

                    'Trace.Warn(sMessage)

                    L2 = gr.FindControl("HoganUserName")
                    sMessage = Replace(sMessage, "|UserName|", L2.Text)
                    L2 = gr.FindControl("HoganUserPassword")
                    sMessage = Replace(sMessage, "|UserPassword|", L2.Text)

                    bdp1 = Me.tabCandidates.FooterRow.FindControl("DueDate")
                    Trace.Warn(Format(bdp1.SelectedValue, "dd-MMM-yy"))
                    sMessage = Replace(sMessage, "|DueDate|", fsDate(bdp1.SelectedValue, sCultureInit))

                    ''''''''''''''''''''
                    Trace.Warn(sMessage)
                    sMessage = Replace(sMessage, vbCrLf, vbCrLf & "<br>")


                    'Emails.relayEmail_Send(TAdminEmailAddress.Text, L1.Text, "", sSubject, sMessage)

                    'Cliff: replicating the notification logic in relayEmail_Send
                    Dim sSendResult As String = CF.Email_Send(TAdminEmailAddress.Text, L1.Text, "", sSubject, sMessage)

                    If (sSendResult <> String.Empty) Then
                        CF.Email_Send("odgers@perfprog.com", "", "", "odgers Error", " Errors: " & sSendResult)
                    End If

                    CF.Email_Send("odgers@perfprog.com", "", "", "odgers Update", "Email sent to " & L1.Text)

                    sSql = "Update AssgnCandidates Set EmailDate=getDate() where AssgnID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("AssgnID")
                    sSql = sSql & " and CandidateID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("CandidateID")
                    Trace.Warn(sSql)
                    CF.Runquery(sSql)
                End If
            End If
        Next

        If iCount > 0 Then
            sScript = "<script>alert('" & iCount & " message(s) sent');</script>"
            Me.divalert.InnerHtml = sScript
        End If
    End Sub




    Sub Candidates_Email_v1()
        Dim gr As GridViewRow, chk1 As CheckBox, L1 As Label, dd1 As DropDownList
        Dim sSubject As String, sMessage As String, L2 As Label, sParticipantName As String
        Dim bdp1 As BasicFrame.WebControls.BDPLite, sSql As String, i1 As Integer
        Dim TAdminEmailAddress As TextBox, iCount As Integer, sScript As String
        Dim sCultureInit As String

        TAdminEmailAddress = Me.tabDetail.FindControl("AdminEmailAddress")
        Trace.Warn(TAdminEmailAddress.Text)

        Dim dvE As System.Data.DataView
        dvE = Me.rsLang.Select(DataSourceSelectArguments.Empty)
        sCultureInit = "en-US"
        iCount = 0
        For Each gr In Me.tabCandidates.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                chk1 = gr.FindControl("SendEmail")
                L1 = gr.FindControl("EmailAddress")
                dd1 = gr.FindControl("LanguageID")
                If chk1.Checked Then
                    iCount = iCount + 1
                    For i1 = 0 To dvE.Table.Rows.Count - 1
                        If dvE.Table.Rows(i1)("LanguageID") = dd1.SelectedValue Then
                            sSubject = CF.NullToString(dvE.Table.Rows(i1)("EmailSubject"))
                            sMessage = CF.NullToString(dvE.Table.Rows(i1)("EmailMessage"))
                            sCultureInit = CF.NullToString(dvE.Table.Rows(i1)("CultureInit"))
                            'Trace.Warn("Message=" & sMessage)
                            Exit For
                        End If
                    Next

                    'Substitutions
                    L2 = gr.FindControl("FirstName")
                    sMessage = Replace(sMessage, "|FirstName|", L2.Text)

                    L2 = gr.FindControl("LastName")
                    sMessage = Replace(sMessage, "|LastName|", L2.Text)

                    'Trace.Warn(sMessage)

                    L2 = gr.FindControl("HoganUserName")
                    sMessage = Replace(sMessage, "|UserName|", L2.Text)
                    L2 = gr.FindControl("HoganUserPassword")
                    sMessage = Replace(sMessage, "|UserPassword|", L2.Text)

                    bdp1 = Me.tabCandidates.FooterRow.FindControl("DueDate")
                    Trace.Warn(Format(bdp1.SelectedValue, "dd-MMM-yy"))
                    sMessage = Replace(sMessage, "|DueDate|", fsDate(bdp1.SelectedValue, sCultureInit))

                    ''''''''''''''''''''
                    Trace.Warn(sMessage)
                    sMessage = Replace(sMessage, vbCrLf, vbCrLf & "<br>")


                    'Emails.relayEmail_Send(TAdminEmailAddress.Text, L1.Text, "", sSubject, sMessage)

                    'Cliff: replicating the notification logic in relayEmail_Send
                    Dim sSendResult As String = CF.Email_Send(TAdminEmailAddress.Text, L1.Text, "", sSubject, sMessage)

                    If (sSendResult <> String.Empty) Then
                        CF.Email_Send("odgers@perfprog.com", "", "", "odgers Error", " Errors: " & sSendResult)
                    End If

                    CF.Email_Send("odgers@perfprog.com", "", "", "odgers Update", "Email sent to " & L1.Text)


                    sSql = "Update AssgnCandidates Set EmailDate=getDate() where AssgnID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("AssgnID")
                    sSql = sSql & " and CandidateID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("CandidateID")
                    Trace.Warn(sSql)
                    CF.Runquery(sSql)
                End If
            End If
        Next

        If iCount > 0 Then
            sScript = "<script>alert('" & iCount & " message(s) sent');</script>"
            Me.divalert.InnerHtml = sScript
        End If
    End Sub

    Function fsDate_orig(ByVal d1 As Date, ByVal iLanguageID As Integer) As String
        Dim aMonthNames(13) As String

        aMonthNames(1) = "janvier"
        aMonthNames(2) = "février"
        aMonthNames(3) = "mars"
        aMonthNames(4) = "avril"
        aMonthNames(5) = "mai"
        aMonthNames(6) = "juin"
        aMonthNames(7) = "juillet"
        aMonthNames(8) = "août"
        aMonthNames(9) = "septembre"
        aMonthNames(10) = "octobre"
        aMonthNames(11) = "novembre"
        aMonthNames(12) = "décembre"

        If iLanguageID = 1 Or iLanguageID = 4 Then
            fsDate_orig = Format(d1, "MMM d")
        Else
            fsDate_orig = d1.Day & " " & aMonthNames(d1.Month)
        End If
    End Function

    Function fsDate(ByVal d1 As Date, ByVal sCultureInit As String) As String
        fsDate = d1.ToString("M", New System.Globalization.CultureInfo(sCultureInit))


    End Function
    Sub Candidates_Update()
        Dim gr As GridViewRow, L1 As Label, T1 As TextBox, sSql As String
        Dim chk1 As CheckBox, sMessage As String, hl1 As HyperLink
        Dim iFinalCount As Integer, sScript As String

        iFinalCount = 0
        For Each gr In Me.tabCandidates.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                'T1 = gr.FindControl("Comments")
                chk1 = gr.FindControl("IsFinal")

                Trace.Warn("Updating " & gr.RowIndex)
                'sSql = "Update AssgnCandidates Set Comments='" & Replace(T1.Text, "'", "''") & "'"
                sSql = "Update AssgnCandidates Set Comments=''"
                If chk1.Checked Then
                    sSql = sSql & ", IsFinal=1"

                    'Send Email to Sonya
                    sMessage = "Office: " & Me.OfficeID.SelectedItem.Text
                    T1 = Me.tabDetail.FindControl("AssgnDesc")
                    sMessage = sMessage & "<br><br>" & "Assignment=" & T1.Text

                    hl1 = gr.FindControl("CandidateName")
                    sMessage = sMessage & "<br><br>" & "Candidate=" & hl1.Text

                    L1 = gr.FindControl("HoganUserName")
                    sMessage = sMessage & "<br><br>" & "Hogan UserName=" & L1.Text

                    Trace.Warn(sMessage)
                    CF.Email_Send("obportal@perfprog.com", "sonya@performanceprograms.com", "", "Odgers - Final Candidate Selected", sMessage)

                    iFinalCount = iFinalCount + 1
                Else
                    sSql = sSql & ", IsFinal=0"
                End If
                sSql = sSql & " where AssgnID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("AssgnID")
                sSql = sSql & " and CandidateID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("CandidateID")
                Trace.Warn(sSql)
                CF.Runquery(sSql)

                If iFinalCount > 0 Then
                    sScript = "<script language=""javascript"" type=""text/javascript"">"
                    sScript = sScript & "alert('" & iFinalCount & " final selection(s) sent to PPI. The report will be generated within 24 hours.')"
                    sScript = sScript & "</script>"
                    Response.Write(sScript)
                End If
            End If
        Next
    End Sub

    Protected Sub tabCandidates_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabCandidates.RowDataBound
        Dim i1 As Integer, hl1 As HyperLink, L1 As Label, sSrcFileName As String
        Dim sTargetFileName As String, f1 As System.IO.FileInfo, L2 As Label
        Dim chk1 As CheckBox

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
                e.Row.Cells(6).Controls.Add(L2)

                hl1 = New HyperLink
                e.Row.Cells(6).Controls.Add(hl1)
                Trace.Warn(sSrcFileName)
                hl1.Text = ReportType_Get(sSrcFileName) & "<br>"
                hl1.NavigateUrl = ConfigurationManager.AppSettings("ReportsFolderName") & "/" & sSrcFileName
                hl1.Target = "new"

                chk1 = e.Row.Cells(7).FindControl("DoDelete")
                chk1.Visible = False
            Next
        End If

Folders_Done:
        'Hogan codes type
        Dim sAssgnType As String, dv1 As System.Data.DataView
        dv1 = Me.rsDetail.Select(DataSourceSelectArguments.Empty)
        If dv1 Is Nothing Then Exit Sub
        If dv1.Table.Rows.Count = 0 Then Exit Sub

        sAssgnType = dv1.Table.Rows(0)("AssgnTypeID")
        If e.Row.RowType = DataControlRowType.DataRow Then
            L1 = e.Row.FindControl("AssgnTypeID")
            If L1.Text <> sAssgnType Then
                L1 = e.Row.FindControl("AssgnTypeName")
                L1.CssClass = "error"
            End If
        End If
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

    Protected Sub tabSearch_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles tabSearch.RowCommand
        Dim sSql As String, btn As Button, gr As GridViewRow
        If e.CommandName = "Select" Then
            btn = e.CommandSource
            gr = btn.NamingContainer
            Trace.Warn(Me.tabSearch.DataKeys(gr.RowIndex)("CandidateID"))
            sSql = "Insert into AssgnCandidates(AssgnID, CandidateID) Select "
            sSql = sSql & Me.tabList.SelectedValue
            sSql = sSql & ", " & Me.tabSearch.DataKeys(gr.RowIndex)("CandidateID")
            Trace.Warn(sSql)
            CF.Runquery(sSql)

            Me.tabCandidates.DataBind()
            Me.tabSearch.DataBind()
        End If
    End Sub

    Sub Candidates_Delete()
        Dim gr As GridViewRow, chk1 As CheckBox, sSql As String

        For Each gr In Me.tabCandidates.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                chk1 = gr.FindControl("DoDelete")
                If chk1.Checked Then
                    Trace.Warn("Deleting " & gr.RowIndex)
                    sSql = "Delete from AssgnCandidates"
                    sSql = sSql & " where AssgnID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("AssgnID")
                    sSql = sSql & " and CandidateID=" & Me.tabCandidates.DataKeys(gr.RowIndex)("CandidateID")
                    Trace.Warn(sSql)
                    CF.Runquery(sSql)
                End If
            End If
        Next
        Me.tabCandidates.DataBind()
        Me.tabSearch.DataBind()
    End Sub

    Protected Sub tabDetail_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewUpdatedEventArgs) Handles tabDetail.ItemUpdated
        Me.tabList.DataBind()
        Me.tabCandidates.DataBind()
    End Sub

    Protected Sub tabDetail_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles tabDetail.PreRender
        Dim btn1 As Button

        If Me.tabDetail.Rows.Count = 0 Then Exit Sub

        btn1 = Me.tabDetail.FindControl("btnDelete")
        Trace.Warn("A")
        If btn1 Is Nothing Then
        Else
            If Not IsNew Then
                Trace.Warn("B")
                If Request.Cookies("OfficeID").Value = 999 Then
                    Trace.Warn("C")
                    btn1.Enabled = True
                Else
                    Trace.Warn("D")
                    btn1.Enabled = False
                End If
            End If
        End If


        'Report Type
        Dim dd1 As DropDownList, i1 As Integer, l1 As ListItem
        dd1 = Me.tabDetail.FindControl("AssgnTypeID")
        Trace.Warn("dd1=" & dd1.Items.Count)
        dd1.Attributes.Add("onchange", "reporttype_alert();")
        dd1.Attributes.Add("onfocus", "reporttype_remember();")

        For i1 = 0 To dd1.Items.Count - 1
            If InStr(dd1.Items(i1).Text, "not available") > 0 Then
                l1 = dd1.Items(i1)
                l1.Attributes.Add("disabled", "true")
            End If
        Next
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Me.tabSearch.DataBind()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("OfficeID") <> "" Then
                Me.OfficeID.SelectedValue = Request.QueryString("OfficeID")
                tabList_Select()
            End If
        End If
    End Sub

    Sub tabList_Select()
        Dim sSql As String
        sSql = Me.rsList.SelectCommand
        sSql = Left(sSql, InStr(sSql, "where") - 1)
        sSql = sSql & " where AssgnID=" & Request.QueryString("AssgnID")
        Trace.Warn(sSql)
        Me.rsList.SelectCommand = sSql
        Me.rsList.DataBind()
        Me.tabList.SelectedIndex = 0
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        Me.pCandidates.Visible = (Me.tabList.SelectedIndex >= 0)
        Me.pQuickadd.Visible = (Me.tabList.SelectedIndex >= 0)


    End Sub

    Protected Sub btnReload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReload.Click
        Me.rsCandidates.DataBind()
        Me.tabCandidates.DataBind()
    End Sub

    Protected Sub OfficeID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles OfficeID.SelectedIndexChanged
        Me.StartsWith.Text = " "
    End Sub
End Class
