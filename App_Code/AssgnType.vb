Imports Microsoft.VisualBasic

Public Class AssgnType
    Private _IsBenchMark As Boolean
    Private _ShowGraph As Boolean
    Private _RptName As String
    Private _IsHBC As Boolean
    Property IsBenchmark() As Boolean
        Get
            Return _IsBenchMark
        End Get
        Set(ByVal Value As Boolean)
            _IsBenchMark = Value
        End Set
    End Property

    Property ShowGraph() As Boolean
        Get
            Return _ShowGraph
        End Get
        Set(ByVal Value As Boolean)
            _ShowGraph = Value
        End Set
    End Property

    Property RptName() As String
        Get
            Return _RptName
        End Get
        Set(ByVal Value As String)
            _RptName = Value
        End Set
    End Property

    Property IsHBC() As Boolean
        Get
            Return _IsHBC
        End Get
        Set(ByVal Value As Boolean)
            _IsHBC = Value
        End Set
    End Property


    Public Sub New(ByVal iAssgnTypeID As Integer)
        'Benchmark
        '21: HBC Benchmark English
        '23: HBC Benchmark French
        '19: Odgers Benchmark
        '30: Odgers Benchmark with Graph


        'Potential 
        '20: HBC Potential English
        '22: HBC Potential French
        '18: Odgers Potential
        '42: Odgers Potential with Graph

        'Free
        '43: Odgers Benchmark
        '44: Odgers Benchmark with Graph
        '45: Odgers Potential
        '46: Odgers Potential with Graph

        'This version of the report will NOT support HBC versions
        _IsBenchMark = False
        _ShowGraph = False
        _RptName = "OBUnknown" & iAssgnTypeID
        _IsHBC = False

        If iAssgnTypeID = 20 Or iAssgnTypeID = 21 _
            Or iAssgnTypeID = 22 Or iAssgnTypeID = 23 Then
            _IsHBC = True
            If iAssgnTypeID = 21 Or iAssgnTypeID = 23 Then
                _ShowGraph = True
                _RptName = "OBBenchmark"
            Else
                _RptName = "OBPotential"
            End If
            Exit Sub


        Else
            _IsHBC = False
        End If


        If iAssgnTypeID = 19 Or iAssgnTypeID = 30 _
            Or iAssgnTypeID = 43 Or iAssgnTypeID = 44 Then
            _IsBenchMark = True
            If iAssgnTypeID = 30 Or iAssgnTypeID = 44 Then
                _ShowGraph = True
                _RptName = "OBBenchmarkGraph"
            Else
                _RptName = "OBBenchmark"
            End If

        ElseIf iAssgnTypeID = 18 Or iAssgnTypeID = 42 _
            Or iAssgnTypeID = 45 Or iAssgnTypeID = 46 Then
            _IsBenchMark = False
            If iAssgnTypeID = 42 Or iAssgnTypeID = 46 Then
                _ShowGraph = True
                _RptName = "OBPotentialGraph"
            Else
                _RptName = "OBPotential"
            End If
        Else
            'Should never come here - unknown assignment type
            'will be treated as Potential without Graph

        End If

    End Sub

End Class
