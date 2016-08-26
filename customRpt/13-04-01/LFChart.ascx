<%@ Control Language="VB" AutoEventWireup="false" CodeFile="LFChart.ascx.vb" Inherits="C2_LFChart" %>
<asp:SqlDataSource ID="rsA" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
    SelectCommand="SELECT [CandidateID], [ScaleID], [Score], [ScaleName], [NormScore] FROM [qryLFChart] WHERE ([CandidateID] = @CandidateID) ORDER BY [ScaleID]">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="1" Name="CandidateID" QueryStringField="CandidateID"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<table border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td style="border-bottom:1px solid black;">
            SCALE
        </td>
        <td style="border-bottom:1px solid black;"  class="notes">
            score
        </td>
        <td valign="bottom" style="background-image: url(../images/Table-Top-b.jpg); background-position:bottom;  background-repeat: no-repeat; "> </td>
    </tr>
    <asp:Repeater runat="server" ID="tabA" DataSourceID="rsA">
        <ItemTemplate>
            <tr>
                <td valign="middle" style="padding-right: 20px; border-bottom: 1px solid black;">
                    <asp:Label runat="server" ID="ScaleName" Text='<%# Eval("ScaleName") %>'></asp:Label>
                </td>
                <td align="right" valign="middle" style="padding-right: 20px; border-bottom: 1px solid black;">
                    <asp:Label runat="server" ID="Score" Text='<%# Eval("Score") %>'></asp:Label>
                </td>
                <td valign="middle" height="30" width="321" style="background-image: url(../images/Table-Middle-50px.jpg);
                    padding-left: 1px; border-bottom: 1px solid black;">
                    <img runat="server" id="bar1" src="../images/small-chart-Blue.jpg" width="75" height="11" />
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    <tr>
        <td>
        </td>
        <td>
        </td>
        <td style="background-image: url(../images/Table-Bottom.jpg); height: 5px;">
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td>
        </td>
        <td>
            <table width="321" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" width="80" class="notes">
                        DEVELOPING
                    </td>
                    <td align="center" width="80" class="notes">
                        PROFICIENT
                    </td>
                    <td align="center" width="80" class="notes">
                        STRONG
                    </td>
                    <td align="center" width="81" class="notes">
                        OUTSTANDING
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
