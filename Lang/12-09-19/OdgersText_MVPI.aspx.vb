
Partial Class Lang_OdgersText_HPI
    Inherits System.Web.UI.Page
    Dim L1 As Label, T1 As TextBox

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
        sSql = "Update OdgersText_MVPI Set " & Mid(sSql, 2)
        sSql = sSql & " where AutoID=" & L1.Text
        Trace.Warn(sSql)
        CF.Runquery(sSql)
        Me.tabA.DataBind()
    End Sub

    Protected Sub tabA_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabA.ItemDataBound
        Dim i1 As Integer
        For i1 = 0 To e.Item.Controls.Count - 1
            If e.Item.Controls(i1).GetType.ToString = "System.Web.UI.WebControls.TextBox" Then
                Trace.Warn(e.Item.Controls(i1).ID & "=" & e.Item.Controls(i1).SkinID)
                T1 = e.Item.Controls(i1)
                T1.Attributes.Add("onkeyup", "count_show('" & T1.ClientID & "', " & Len(e.Item.DataItem("Eng" & T1.ID)) & ", '" & "charsleft" & T1.SkinID & "');")

            End If


        Next
    End Sub
End Class
