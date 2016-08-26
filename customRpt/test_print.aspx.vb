Imports WebSupergoo.ABCpdf9

Partial Class CustomRpt_test_print
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim theURL As String, theID As Integer
        Dim theDoc As Doc

        XSettings.License = "810-031-225-276-6105-881"
        
        theDoc = New Doc


        theURL = "https://obportal.perfprog.com/CustomRpt/test_pt.aspx?ID=" & Request.QueryString("ID")
        'theURL = "http://localhost:55871/Odgers_Live/CustomRpt/test_pt.aspx?ID=" & Request.QueryString("ID")
        Trace.Warn(theURL)

        theDoc.HtmlOptions.FontEmbed = True
        theDoc.HtmlOptions.FontSubstitute = False
        theDoc.HtmlOptions.FontProtection = False


        'Add Pages
        theDoc.Rect.Position(10, 30) 'was 40,40
        theDoc.Rect.Width = 592 'was 530
        theDoc.Rect.Height = 740 'was 700
        'theDoc.FrameRect()

        theID = theDoc.AddImageUrl(theURL, True, 0, True)
        Do
            If theDoc.GetInfo(theID, "Truncated") <> "1" Then Exit Do
            theDoc.Page = theDoc.AddPage()
            'theDoc.FrameRect()
            theID = theDoc.AddImageToChain(theID)
        Loop

        theDoc.Save("c:\inetpub\wwwroot\odgers_live\HoganReports\test_pt.pdf")

        theDoc.Dispose()
        theDoc = Nothing

    End Sub
End Class
