
Partial Class Lang_OdgersText_HPI
    Inherits System.Web.UI.Page

    Protected Sub tabA_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles tabA.ItemCommand
        If e.CommandName = "Save1" Then
        Else
            Exit Sub
        End If

        'List all the controls
        Dim i1 As Integer, sSql As String, T1 As TextBox, L1 As Label
        sSql = ""
        For i1 = 0 To e.Item.Controls.Count - 1
            'Trace.Warn(e.Item.Controls(i1).ID & "=" & e.Item.Controls(i1).GetType.ToString)
            If e.Item.Controls(i1).GetType.ToString = "System.Web.UI.WebControls.TextBox" Then
                T1 = e.Item.Controls(i1)
                sSql = sSql & ", " & T1.ID & "='" & Replace(T1.Text, "'", "''") & "'"
            End If
        Next

        'Put it together
        L1 = e.Item.FindControl("AutoID")
        sSql = "Update OdgersText_HPI Set " & Mid(sSql, 2)
        sSql = sSql & " where AutoID=" & L1.Text
        Trace.Warn(sSql)
        CF.Runquery(sSql)
        Me.tabA.DataBind()
    End Sub
End Class
