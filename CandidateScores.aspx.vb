
Partial Class CandidateScores
    Inherits System.Web.UI.Page

    Protected Sub frmC_ItemCommand(sender As Object, e As System.Web.UI.WebControls.FormViewCommandEventArgs) Handles frmC.ItemCommand

        If e.CommandName = "Calc" Then
            CF.Runquery("Exec Results_Calc " & Me.frmC.SelectedValue)
            Me.frmC.DataBind()

        End If
    End Sub
End Class
