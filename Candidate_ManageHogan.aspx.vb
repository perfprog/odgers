
Partial Class CandidateScores
    Inherits System.Web.UI.Page
    Dim dvReportTypes As System.Data.DataView
    Dim tr1 As HtmlTableRow, tc1 As HtmlTableCell
    Dim sAssmtList As String, sRptList As String, sAddAssmtList As String, sAddRptList As String
    Dim a1() As String, i1 As Integer, li As ListItem, a2() As String
    Dim chk1 As CheckBox, sLangs As String, rad1 As RadioButtonList
    Dim sSql As String, gr As GridViewRow, L1 As Label
    Dim dvLangs As System.Data.DataView, drLang As System.Data.DataRow



    Sub Reports_Show(sHoganUserName As String)
        Dim sFolderName As String, sFileNames() As String
        Dim i1 As Integer, hl1 As HyperLink

        'Show Report Links
        If sHoganUserName = "" Then Exit Sub

        sFolderName = (ConfigurationManager.AppSettings("ReportsFolderName"))
        sFolderName = System.Web.HttpContext.Current.Server.MapPath(sFolderName)
        AF.Debug_Show((sFolderName))
        sFileNames = System.IO.Directory.GetFiles((sFolderName), sHoganUserName & "-*.pdf")
        AF.Debug_Show(sHoganUserName & " " & UBound(sFileNames))
        If UBound(sFileNames) = -1 Then Exit Sub

        For i1 = 0 To UBound(sFileNames)
            AF.Debug_Show(sFileNames(i1))
            hl1 = New HyperLink

            hl1.Text = ReportType_Get(sFileNames(i1))
            hl1.NavigateUrl = ConfigurationManager.AppSettings("ReportsFolderName") & "/" & CF.FileName_Get(sFileNames(i1))
            hl1.Target = "rpt"
            tabRpt_Add(hl1)
        Next
    End Sub

    Sub tabRpt_Add(link1 As HyperLink)
        tr1 = New HtmlTableRow
        Me.rptList.Rows.Add(tr1)
        tc1 = New HtmlTableCell
        tr1.Cells.Add(tc1)

        tc1.Controls.Add(link1)
    End Sub

    'copied from assignments.aspx
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

    
    Protected Sub tabCan_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabCan.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            sAssmtList = sAssmtList & ", " & e.Row.DataItem("HoganAssessList")
            sRptList = sRptList & ", " & e.Row.DataItem("HoganRptList")
            sAddAssmtList = sAddAssmtList & ", " & CF.NullToString(e.Row.DataItem("AddAssmts"))
            sAddRptList = sAddRptList & ", " & CF.NullToString(e.Row.DataItem("AddRpts"))
        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            Trace.Warn(sAssmtList)
            Trace.Warn(sRptList)

            'Default Assessments
            a1 = Split(sAssmtList, ", ")
            For i1 = 0 To UBound(a1)
                For Each li In Me.AddAssmts.Items
                    If li.Text = a1(i1) Then
                        li.Selected = True
                        li.Enabled = False
                    End If
                Next
            Next

            'Added Assessments
            a1 = Split(sAddAssmtList, ", ")
            For i1 = 0 To UBound(a1)
                For Each li In Me.AddAssmts.Items
                    If li.Text = a1(i1) Then
                        li.Selected = True
                        li.Enabled = False
                        li.Attributes.Add("style", "background-color: Green;")
                    End If
                Next
            Next
        End If
    End Sub



    Protected Sub tabRpts_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabRpts.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Report CheckBox
            a1 = Split(sRptList, ", ")
            For i1 = 0 To UBound(a1)
                If e.Row.DataItem("ReportTypeID") = a1(i1) Then
                    chk1 = e.Row.FindControl("DoSelect")
                    chk1.Checked = True
                    chk1.Enabled = False

                    chk1.Text = chk1.Text & " (OB)"
                    Exit For
                End If
            Next


            'Languages
            sLangs = CF.NullToString(e.Row.DataItem("LangInits"))
            rad1 = e.Row.FindControl("HoganLangs")
            a1 = Split(sLangs, ", ")
            For i1 = 0 To UBound(a1)
                If a1(i1) <> "" Then
                    li = New ListItem
                    rad1.Items.Add(li)
                    li.Text = LangName_Get(a1(i1))
                    li.Value = a1(i1)
                    If a1(i1) = "EN" Then
                        li.Selected = True
                    End If
                End If
            Next


            'Border
            e.Row.Style.Add("border-bottom", "1px solid navy;")

            'Added Reports
            a1 = Split(sAddRptList, ", ")
            For i1 = 0 To UBound(a1)
                If a1(i1) <> "" Then
                    chk1 = e.Row.FindControl("DoSelect")
                    rad1 = e.Row.FindControl("HoganLangs")
                    a2 = Split(a1(i1), "-")
                    Trace.Warn(a2(0) & " ??? " & e.Row.DataItem("ReportTypeID"))
                    If Trim(e.Row.DataItem("ReportTypeID")) = Trim(a2(0)) Then
                        chk1.Checked = True
                        chk1.Enabled = False
                        chk1.Attributes.Add("style", "background-color: Green;")

                        rad1.SelectedValue = a2(1)
                        Exit For
                    End If
                End If
            Next
        End If

    End Sub

    Function LangName_Get(sInit As String) As String
        If dvLangs Is Nothing Then
            dvLangs = CF.DataView_Get("Select LangInit, LangName from HoganLangs order by LangInit")
        End If

        For Each drLang In dvLangs.Table.Rows
            If drLang("LangInit") = sInit Then
                LangName_Get = drLang("LangName")
                Exit Function
            End If
        Next

        LangName_Get = sInit

    End Function
    Protected Sub btnAddAssmts_Click(sender As Object, e As System.EventArgs) Handles btnAddAssmts.Click
        sSql = ""
        For Each li In Me.AddAssmts.Items
            If li.Enabled = True Then
                If li.Selected = True Then
                    sSql = sSql & ", " & li.Value
                End If
            End If
        Next
        If sSql <> "" Then
            sSql = Mid(sSql, 3)
            sSql = "Update Candidates Set AddAssmts=IsNull(AddAssmts, '') + ', " & sSql & "' where CandidateID=" & Request.QueryString("CandidateID")
            Trace.Warn(sSql)
            CF.Runquery(sSql)
        End If

    End Sub

    Protected Sub btnAddRpts_Click(sender As Object, e As System.EventArgs) Handles btnAddRpts.Click
        sSql = ""
        For Each gr In Me.tabRpts.Rows
            chk1 = gr.FindControl("DoSelect")
            If chk1.Checked = True Then
                Trace.Warn(chk1.Text, InStr(chk1.Text, "OB"))
                If InStr(chk1.Text, "(OB)") = 0 Then
                    L1 = gr.FindControl("ReportTypeID")
                    sSql = sSql & ", " & L1.Text

                    rad1 = gr.FindControl("HoganLangs")
                    sSql = sSql & "-" & rad1.SelectedValue

                    'Get Assessments
                    L1 = gr.FindControl("AssmtsList")
                    a1 = Split(L1.Text, ", ")
                    For i1 = 0 To UBound(a1)
                        If a1(i1) <> "" Then
                            For Each li In Me.AddAssmts.Items
                                If li.Selected = False Then
                                    If li.Value = a1(i1) Then
                                        li.Selected = True
                                    End If
                                End If
                            Next
                        End If
                    Next
                End If
            End If
        Next
        Trace.Warn(sSql)
        If sSql <> "" Then
            sSql = Mid(sSql, 3)
            sSql = "Update Candidates Set AddRpts='" & sSql & "' where CandidateID=" & Request.QueryString("CandidateID")
            Trace.Warn(sSql)
            CF.Runquery(sSql)

            btnAddAssmts_Click(sender, e)
            Me.tabCan.DataBind()
            Me.tabRpts.DataBind()
            Me.AddAssmts.DataBind()
        End If
    End Sub

    Sub HoganPortal_Update()

    End Sub

    'Rules:
    '1. Default report type is not saved in Candidates.AddRpts
    '2. Report selection is saved as "ReportTypeID-LangInit"
    '3. Default reports are marked with "(OB)" in Text

    

    
    Protected Sub frmCan_ItemCreated(sender As Object, e As System.EventArgs) Handles frmCan.ItemCreated
        If Not Page.IsPostBack Then
            Reports_Show(Me.frmCan.DataItem("HoganUserName"))
        End If

    End Sub
End Class
