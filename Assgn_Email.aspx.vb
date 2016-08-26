
Partial Class Assignment_Emails
    Inherits System.Web.UI.Page

    Protected Sub tabE_ItemCommand(source As Object, e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles tabE.ItemCommand
        If e.CommandName = "Save" Then
            Dim sSql As String, T1 As TextBox

            sSql = "Update Assgn_Email Set "
            T1 = e.Item.FindControl("EmailSubject")
            sSql = sSql & " EmailSubject='" & Replace(T1.Text, "'", "''") & "'"

            T1 = e.Item.FindControl("EmailMessage")
            sSql = sSql & ", EmailMessage='" & Replace(T1.Text, "'", "''") & "'"

            sSql = sSql & " where AssgnID=" & Request.QueryString("AssgnID")
            Trace.Warn(sSql)
            CF.Runquery(sSql)
            Me.Message.Text = "Changes saved."
        End If
    End Sub

    Protected Sub tabE_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabE.ItemDataBound
        Me.OfficeID.Text = e.Item.DataItem("OfficeID")
    End Sub

    Protected Sub tabLang_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabLang.ItemDataBound
        Dim tbl1 As HtmlTable
        tbl1 = e.Item.FindControl("tab1")


        If e.Item.DataItem("LanguageID") = Me.LanguageID.SelectedValue Then
            tbl1.Visible = True
            Trace.Warn("xxx" & e.Item.DataItem("LanguageID"))
        Else

            tbl1.Visible = False
            Trace.Warn("yyy" & e.Item.DataItem("LanguageID"))
        End If
    End Sub

    Protected Sub LanguageID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles LanguageID.SelectedIndexChanged
        tabLang.DataBind()
    End Sub

    Protected Sub btnCopy_Click(sender As Object, e As System.EventArgs) Handles btnCopy.Click
        Dim sSql As String
        sSql = "Update Assgn_Email set EmailSubject=L1.EmailSubject, EmailMessage=L1.EmailMessage, CultureInit=L1.CultureInit from Assgn_Email, Languages L1"
        sSql = sSql & " where AssgnID=" & Request.QueryString("AssgnID")
        sSql = sSql & " and L1.LanguageID=" & Me.LanguageID.SelectedValue
        Trace.Warn(sSql)
        CF.Runquery(sSql)
        Me.Message.Text = "Email text copied."
        Me.tabE.DataBind()
    End Sub
End Class
