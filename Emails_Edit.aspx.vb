
Partial Class Emails_Edit
    Inherits System.Web.UI.Page

    Protected Sub tabA_ItemCommand(source As Object, e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles tabA.ItemCommand
        If e.CommandName = "Update1" Then
            Dim sSql As String, L1 As Label, T1 As TextBox, i1 As Integer

            sSql = "Update Languages Set "
            Trace.Warn(Me.tabA.Items.Count)

            For i1 = 0 To Me.tabA.Items.Count - 1
                L1 = Me.tabA.Items(i1).FindControl("LanguageID")
                If L1.Text = Me.LanguageID.SelectedValue Then
                    T1 = Me.tabA.Items(i1).FindControl("EmailSubject")
                    sSql = sSql & "EmailSubject=N'" & Replace(T1.Text, "'", "''") & "'"

                    T1 = Me.tabA.Items(i1).FindControl("EmailMessage")
                    sSql = sSql & ", EmailMessage=N'" & Replace(T1.Text, "'", "''") & "'"


                    sSql = sSql & " Where LanguageID='" & Replace(L1.Text, "'", "''") & "'"
                    Trace.Warn(sSql)
                    CF.Runquery(sSql)
                    Me.Message.Text = "Email Subject and Message updated."
                    Exit For
                End If
            Next

            Me.tabA.DataBind()
        End If
    End Sub

    Protected Sub tabA_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabA.ItemDataBound
        If e.Item.DataItem("LanguageID") <> Me.LanguageID.SelectedValue Then
            e.Item.Controls.Clear()
            Exit Sub
        End If

    End Sub

    Protected Sub LanguageID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles LanguageID.SelectedIndexChanged
        Me.tabA.DataBind()
    End Sub
End Class
