Imports Microsoft.VisualBasic

Public Class AF

    
    Shared Sub Debug_Show(ByVal s1 As String)
        System.Web.HttpContext.Current.Trace.Warn(s1)

    End Sub

    Public Shared Function fsReportFileName_Orig(ByVal sHoganUserName As String, ByVal iAssgnTypeID As Integer, sReportType As String) As String
        fsReportFileName_Orig = ConfigurationManager.AppSettings("Approot_Foldername") & ConfigurationManager.AppSettings("ReportsFoldername") & "\" & sHoganUserName & "-"
        If sReportType = "Appendix" Then
            fsReportFileName_Orig = fsReportFileName_Orig & "OBAppendix"
        Else
            If iAssgnTypeID = 21 Or iAssgnTypeID = 23 Or iAssgnTypeID = 19 Then
                fsReportFileName_Orig = fsReportFileName_Orig & "OBBenchmark"
            Else
                fsReportFileName_Orig = fsReportFileName_Orig & "OBPotential"
            End If
            If sReportType <> "" Then
                fsReportFileName_Orig = fsReportFileName_Orig & " (" & sReportType & ")"
            End If
        End If


        fsReportFileName_Orig = fsReportFileName_Orig & "-General.PDF"

    End Function

    Public Shared Function fsReportFileName(ByVal sHoganUserName As String, ByVal sMiddle As String) As String
        fsReportFileName = ConfigurationManager.AppSettings("Approot_Foldername") & ConfigurationManager.AppSettings("ReportsFoldername") & "\" & sHoganUserName & "-"
        fsReportFileName = fsReportFileName & sMiddle
        fsReportFileName = fsReportFileName & "-General.PDF"

    End Function
End Class
