
Partial Class Office_Manage
    Inherits System.Web.UI.Page
    Dim sList1 As String, li As ListItem, sList2 As String, sActive As String
    Dim sSql As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        'Languages
        sList1 = "0"
        For Each li In Me.LangsList.Items
            If li.Selected Then
                sList1 = sList1 & ", " & li.Value
            End If
        Next
        Trace.Warn(sList1)
        If sList1 = "0" Then
            Me.Message.Text = "Please select at least one language."
            Exit Sub
        End If


        'Assgn Types
        sList2 = "0"
        For Each li In Me.AssgnTypesList.Items
            If li.Selected Then
                sList2 = sList2 & ", " & li.Value
            End If
        Next
        Trace.Warn(sList2)
        If sList2 = "0" Then
            Me.Message.Text = "Please select at least one Assignment Type."
            Exit Sub
        End If

        'Active/Inactive
        Trace.Warn("sActive Checkbox Exist: " & Me.Active.Checked)
        sActive = Me.Active.Checked

        Trace.Warn("sActive Checkbox: " & sActive)
        If (sActive = False) Then
            sActive = 0
        Else
            sActive = 1
        End If
            'sActive = "true"


            'Put it together
            sSql = "Update Offices Set "
            sSql = sSql & " LangsList='" & Replace(sList1, "'", "''") & "'"
            sSql = sSql & ", AssgnTypesList='" & Replace(sList2, "'", "''") & "'"
            sSql = sSql & ", Active=" & sActive & ""
            sSql = sSql & " where OfficeID='" & Replace(Me.OfficeID.SelectedValue, "'", "''") & "'"
            Trace.Warn(sSql)
            CF.Runquery(sSql)
            Me.Message.Text = "Changes saved."
    End Sub

    Sub CheckBoxes_Load()
        'Initialize the checkboxlists
        Dim i1 As Integer, a1() As String, j1 As Integer
        Dim dv1 As System.Data.DataView

        
        'Get The Lists
        dv1 = Me.rsOffices.Select(DataSourceSelectArguments.Empty)
        For i1 = 0 To dv1.Table.Rows.Count - 1
            If dv1.Table.Rows(i1)("OfficeID") = Me.OfficeID.SelectedValue Then
                sList1 = CF.NullToString(dv1.Table.Rows(i1)("LangsList"))
                sList2 = CF.NullToString(dv1.Table.Rows(i1)("AssgnTypesList"))
                Exit For
            End If
        Next

        'Initialize checkboxes to unchecked
        For j1 = 0 To Me.LangsList.Items.Count - 1
            Me.LangsList.Items(j1).Selected = False
        Next

        For j1 = 0 To Me.AssgnTypesList.Items.Count - 1
            Me.AssgnTypesList.Items(j1).Selected = False
        Next

        'Now assign the Lang checkboxes
        a1 = Split(sList1, ", ")
        For i1 = 0 To UBound(a1)
            Trace.Warn(a1(i1))
            For j1 = 0 To Me.LangsList.Items.Count - 1
                If a1(i1) = Me.LangsList.Items(j1).Value Then
                    Me.LangsList.Items(j1).Selected = True
                    If InStr(Me.LangsList.Items(j1).Text, "(0)") = 0 Then
                        Me.LangsList.Items(j1).Enabled = False
                    End If
                    Exit For
                End If
            Next
        Next


        'Now assign the AssgnType checkboxes
        a1 = Split(sList2, ", ")
        For i1 = 0 To UBound(a1)
            Trace.Warn(a1(i1))
            For j1 = 0 To Me.AssgnTypesList.Items.Count - 1
                If a1(i1) = Me.AssgnTypesList.Items(j1).Value Then
                    Me.AssgnTypesList.Items(j1).Selected = True
                    If InStr(Me.AssgnTypesList.Items(j1).Text, "(0)") = 0 Then
                        Me.AssgnTypesList.Items(j1).Enabled = False
                    End If
                    Exit For
                End If
            Next
        Next
    End Sub

    Protected Sub Page_LoadComplete(sender As Object, e As System.EventArgs) Handles Me.LoadComplete
        OfficeID_SelectedIndexChanged()
    End Sub

    Protected Sub Page_PreRenderComplete(sender As Object, e As System.EventArgs) Handles Me.PreRenderComplete
        CheckBoxes_Load()
    End Sub

    Protected Sub OfficeID_SelectedIndexChanged()

        Dim dv1 As System.Data.DataView, sSql As String, g1 As GridView
        Dim sActive As String
        Dim sOffice As String

        sOffice = Replace(Me.OfficeID.SelectedValue, "'", "''")
        If sOffice = "" Then
            sOffice = "20"
        End If

        sSql = "Select Active from Offices where OfficeID='" & sOffice & "'"
        Trace.Warn(sSql)
        dv1 = CF.DataView_Get(sSql)

        sActive = dv1.Table.Rows(0)("Active")
        Trace.Warn("sActive " & sActive)
        Active.Checked = sActive

    End Sub


End Class
