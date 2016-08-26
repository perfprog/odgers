Imports BasicFrame

Partial Class Assignments
    Inherits System.Web.UI.Page
    Dim sFolderName As String, sFileNames() As String
    Dim dvReportTypes As System.Data.DataView

    Protected Sub tabList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tabList.SelectedIndexChanged
        Trace.Warn("A")
        Me.tabDetail.ChangeMode(DetailsViewMode.Edit)
        Me.tabDetail.Visible = True
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Trace.Warn("B")
        Me.tabDetail.ChangeMode(DetailsViewMode.Insert)
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

        'Make sure the group code is unique
        Dim dv1 As System.Data.DataView
        dv1 = CF.DataView_Get("Select UserName from AdminUsers where UserName='" & Replace(e.Values("UserName"), "'", "''") & "'")
        If dv1.Table.Rows.Count > 0 Then
            e.Cancel = True
            Me.Message.Text = "This User Name is in use. Please try again."
            Exit Sub
        End If
    End Sub

    
    
    Protected Sub tabDetail_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles tabDetail.PreRender
        Dim btn1 As Button
        Exit Sub

        If Me.tabDetail.Rows.Count = 0 Then Exit Sub
        btn1 = Me.tabDetail.FindControl("btnDelete")

        If Request.Cookies("OfficeID").Value = 999 Then
            btn1.Enabled = True
        Else
            btn1.Enabled = False
        End If
    End Sub

    
End Class
