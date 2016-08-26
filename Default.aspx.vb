

Partial Class Index
    Inherits System.Web.UI.Page

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        Dim dv As System.Data.DataView, sSql As String

        sSql = "Select UserName, FirstName, LastName, UserLevel, OfficeID, OfficeName, Active from qryAdminUsers where "
        sSql = sSql & "UserName='" & Replace(Me.UserName.Text, "'", "''") & "'"
        sSql = sSql & " and UserPassword='" & Replace(Me.UserPassword.Text, "'", "''") & "'"
        Trace.Warn(sSql)

        dv = CF.DataView_Get(sSql)
        If dv.Table.Rows.Count = 0 Then
            Me.Message.Text = "Invalid Login. Please try again."
            Exit Sub
        End If

        If dv.Table.Rows(0)("OfficeID") <> 999 Then
            If dv.Table.Rows(0)("Active") = False Then
                Me.Message.Text = "<br>This account is temporarily disabled.  Please contact Dianne Berner at <a href='mailto:dianne@performanceprograms.com'>dianne@performanceprograms.com</a> for assistance.  Thank you."
                Exit Sub
            End If
        End If

        'Valid Login
        Response.Cookies("UserName").Value = Me.UserName.Text
        Response.Cookies("FullName").Value = dv.Table.Rows(0)("FirstName") & " " & dv.Table.Rows(0)("LastName")
        Response.Cookies("OfficeID").Value = dv.Table.Rows(0)("OfficeID")
        If dv.Table.Rows(0)("OfficeID") = 999 Then
            Response.Cookies("OfficeName").Value = "Super Admin"
        Else
            Response.Cookies("OfficeName").Value = dv.Table.Rows(0)("OfficeName")
        End If
        'PPI Admin Super User
        If dv.Table.Rows(0)("UserName") = "perform" Then
            Response.Cookies("PPIOfficeID").Value = 1000
        Else
            Response.Cookies("PPIOfficeID").Value = 0
        End If
        Response.Redirect("Assignments.aspx")
    End Sub
End Class
