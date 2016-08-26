
Partial Class PPIGeneralError
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Try
            Server.ClearError()
        Catch

        End Try
    End Sub
End Class
