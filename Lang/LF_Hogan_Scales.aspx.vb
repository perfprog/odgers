
Partial Class Lang_Dimensions
    Inherits System.Web.UI.Page
    Dim i1 As Integer, T1 As TextBox, j1 As Integer, L1 As Label

    Protected Sub tabA_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles tabA.RowCommand
        If e.CommandName = "Save" Then
            Data_Save()
        End If
    End Sub

    Sub Data_Save()
        Dim gr As GridViewRow, T1 As TextBox, sSql As String, L1 As Label

        For Each gr In Me.tabA.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                L1 = gr.FindControl("AutoID")
                sSql = "Update Scales Set "
                T1 = gr.FindControl("ScaleName")
                sSql = sSql & " ScaleName=N'" & Replace(T1.Text, "'", "''") & "'"
                T1 = gr.FindControl("ScaleDesc")
                sSql = sSql & ", ScaleDesc=N'" & Replace(T1.Text, "'", "''") & "'"

                T1 = gr.FindControl("HPIScales")
                sSql = sSql & ", HPIScales=N'" & Replace(T1.Text, "'", "''") & "'"

                sSql = sSql & " where"
                sSql = sSql & " AutoID=" & L1.Text
                Trace.Warn(sSql)
                CF.Runquery(sSql)
            End If
        Next
        Me.Message.Text = "Your changes have been saved."
        Me.tabA.DataBind()
    End Sub

    Protected Sub tabA_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabA.RowDataBound
        Trace.Warn(e.Row.Controls.Count)
        For j1 = 0 To e.Row.Cells.Count - 1
            For i1 = 0 To e.Row.Cells(j1).Controls.Count - 1
                If e.Row.Cells(j1).Controls(i1).GetType.ToString = "System.Web.UI.WebControls.TextBox" Then
                    T1 = e.Row.Cells(j1).Controls(i1)
                    L1 = e.Row.Cells(j1).FindControl("charsleft" & T1.SkinID)
                    T1.Attributes.Add("onkeyup", "count_show('" & T1.ClientID & "', " & Len(e.Row.DataItem("Eng" & T1.ID)) & ", '" & L1.ClientID & "');")
                End If
            Next
        Next

        'Hide HoganComps and HPIScales for non-LF scales
        If e.Row.RowType = DataControlRowType.DataRow Then
            'L1 = e.Row.FindControl("EngHoganComps")
            'If L1.Text = "" Then
            '    T1 = e.Row.FindControl("HoganComps")
            '    T1.Visible = False
            'End If

            L1 = e.Row.FindControl("EngHPIScales")
            If L1.Text = "" Then
                T1 = e.Row.FindControl("HPIScales")
                T1.Visible = False
            End If
        End If

    End Sub
End Class
