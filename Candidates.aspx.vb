
Partial Class Candidates
    Inherits System.Web.UI.Page
    Dim iNewID As Long

    Protected Sub frmCandidate_ItemCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewCommandEventArgs) Handles frmCandidate.ItemCommand
        Dim dd1 As DropDownList, L1 As Label

        If e.CommandName = "New" Then
            Response.Redirect("Candidates.aspx?CandidateID=0")
        ElseIf e.CommandName = "Hogan" Then
            dd1 = Me.frmCandidate.FindControl("ddAssgnTypeID")

            HoganCodes_Assign(Me.frmCandidate.DataKey("CandidateID"), dd1.SelectedValue)
            Me.frmCandidate.DataBind()
        ElseIf e.CommandName = "Reports" Then
            L1 = Me.frmCandidate.FindControl("HoganUserName")
            If L1.Text = "" Then
                Me.Message.Text = "No Hogan codes assigned. Report cannot be generated."
            Else
                Import1.PDF_Generate(L1.Text, "")
                Import1.PDF_Generate(L1.Text, "Appendix")
                Me.Message.Text = "Reports are ready."
            End If

        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("CandidateID") = 0 Or Request.QueryString("CandidateID") = "" Then
                Me.frmCandidate.DefaultMode = DetailsViewMode.Insert
            End If
        End If
    End Sub

   

    Protected Sub frmCandidate_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertedEventArgs) Handles frmCandidate.ItemInserted
        'Insert a candidate and associate with an assignment
        Dim sSql As String, sAssgnTypeID As String

        If Request.QueryString("AssgnID") <> "" Then
            sSql = "Insert into AssgnCandidates(AssgnID, CandidateID) Select " & Request.QueryString("AssgnID") & ", "
            sSql = sSql & iNewID
            Trace.Warn(sSql)
            CF.Runquery(sSql)

            sAssgnTypeID = fsAssgnTypeID()
            HoganCodes_Assign(iNewID, sAssgnTypeID)

        End If

        e.KeepInInsertMode = True
        Me.Message.Text = "Candidate added."
    End Sub

    Protected Sub rsCandidate_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles rsCandidate.Inserted
        iNewID = e.Command.Parameters("@NewId").Value
    End Sub

    Protected Sub frmCandidate_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs) Handles frmCandidate.ItemInserting
        'Check if Email Address already exists in the system

    End Sub

    Protected Sub frmCandidate_ItemUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewUpdatedEventArgs) Handles frmCandidate.ItemUpdated
        Me.Message.Text = "Candidate updated."
        'Page.ClientScript.RegisterClientScriptBlock(Page.GetType, "script", "alert('success!'); window.opener.document.forms[0].submit();", True)

    End Sub

    Sub HoganCodes_Assign(ByVal iCandidateID As Long, ByVal sAssgnTypeID As Integer)
        Dim sSql As String, dv1 As System.Data.DataView

        sSql = "Select AssgnTypeID, AssgnTypeName, (Select Count(UserName) from HoganCodes where CandidateID is Null and AssgnTypeID=AssgnTypes.AssgnTypeID) as Count1 from AssgnTypes where AssgnTypeID=" & sAssgnTypeID
        dv1 = CF.DataView_Get(sSql)

        'Check if reload is needed
        If dv1.Table.Rows(0)("Count1") < 10 Then
            'Send message to Sonya
            Trace.Warn("Send Email")
            CF.Email_Send("surveys@performanceprograms.com", "sonya@performanceprograms.com", "", "Reload Hogan Codes for " & dv1.Table.Rows(0)("AssgnTypeName"), "")
        End If

        'Check if there is at least one
        If dv1.Table.Rows(0)("Count1") = 0 Then
            'Should never come here
        End If

        sSql = "Update HoganCodes Set CandidateID=" & iCandidateID & " where UserName="
        sSql = sSql & "(SELECT Top 1 UserName FROM HoganCodes WHERE CandidateID IS NULL and AssgnTypeID='" & sAssgnTypeID & "')"
        Trace.Warn(sSql)
        CF.Runquery(sSql)
    End Sub

    Protected Sub frmCandidate_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles frmCandidate.PreRender
        'Exit Sub
        If frmCandidate.DefaultMode = DetailsViewMode.Insert Then Exit Sub


        Dim div1 As HtmlGenericControl, L1 As Label
        div1 = Me.frmCandidate.FindControl("divHogan")
        Trace.Warn("div1" & div1.ClientID)

        L1 = Me.frmCandidate.FindControl("HoganUserName")
        Trace.Warn("L1" & L1.Text)
        div1.Visible = (L1.Text = "")

        'Scores link
        Dim hl1 As HyperLink
        hl1 = Me.frmCandidate.FindControl("hlScores")
        hl1.Visible = (Request.Cookies("OfficeID").Value = 999)
    End Sub

    Function fsAssgnTypeID() As String
        Dim dv1 As System.Data.DataView, i1 As Integer
        dv1 = CF.DataView_Get("Select AssgnTypeID from Assignments where AssgnID=" & Request.QueryString("AssgnID"))
        If dv1.Table.Rows.Count = 0 Then
            Me.Message.Text = "Unable to assign Hogan Codes. Please report to Admin."
            fsAssgnTypeID = ""
            Exit Function
        End If

        fsAssgnTypeID = dv1.Table.Rows(0)("AssgnTypeID")
    End Function



End Class
