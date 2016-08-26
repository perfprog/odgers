
Partial Class C2_LFChart
    Inherits System.Web.UI.UserControl

    Const cMaxWidth As Integer = 322

    


    Protected Sub tabA_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabA.ItemDataBound
        Dim img1 As HtmlImage
        img1 = e.Item.FindControl("bar1")
        img1.Width = cMaxWidth * e.Item.DataItem("Score") / 100 - 1

        

    End Sub
End Class
