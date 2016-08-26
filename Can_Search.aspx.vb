
Partial Class Admin_Parts_Search
    Inherits System.Web.UI.Page

    

    Protected Sub tabP_PreRender(sender As Object, e As System.EventArgs) Handles tabP.PreRender

        If Me.tabP.Rows.Count = 0 Then
            Me.Message.Text = "No matches found."
        Else
            Me.Message.Text = Me.tabP.Rows.Count & " matches found."
        End If
    End Sub
End Class
