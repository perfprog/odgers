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
        <td colspan="3" align="center" class="h1a">
            <asp:Label runat="server" ID="chart_heading"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="3" style="height: 20px;">
        </td>
    </tr>
    <tr>
        <td style="border-bottom: 1px solid black;">
            <asp:Label runat="server" ID="chart_scale"></asp:Label>
        </td>
        <td style="border-bottom: 1px solid black;" class="notes">
            <asp:Label runat="server" ID="chart_score"></asp:Label>
        </td>
        <%--<td valign="bottom" style="background-image: url(../images/scale_300dpi_322x15_v2.jpg);
            background-position: bottom; background-repeat: no-repeat;">
        </td>--%>
        <td style="border-bottom: 1px solid black;">
            <table width="400" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td align="left" width="80" class="notes">
                        0%
                    </td>
                    <td align="left" width="80" class="notes" style="padding-left:15px;">
                        25%
                    </td>
                    <td align="center" width="80" class="notes">
                        50%
                    </td>
                    <td align="right" width="80" class="notes" style="padding-right:10px;">
                        75%
                    </td>
                    <td align="right" width="80" class="notes">
                        100%
                    </td>
                </tr>
            </table>
        </td>
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
                <td valign="middle" height="30" width="321" style="background-image: url(../images/Table-Middle_400.jpg);padding-left: 1px; border-bottom: 2px solid black;">
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
        <td style="background-image: url(../images/Table-Middle_400.jpg); height: 5px;">
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td>
        </td>
        <td>
            <table width="400" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" width="100" class="notes">
                        <asp:Label runat="server" ID="chart_developing"></asp:Label>
                    </td>
                    <td align="center" width="100" class="notes">
                        <asp:Label runat="server" ID="chart_proficient"></asp:Label>
                    </td>
                    <td align="center" width="100" class="notes">
                        <asp:Label runat="server" ID="chart_strong"></asp:Label>
                    </td>
                    <td align="center" width="100" class="notes">
                        <asp:Label runat="server" ID="chart_outstanding"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
