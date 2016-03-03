unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, ComObj, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Excel_TLB, VBIDE_TLB,
  Math, Graph_TLB, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit6: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Button2: TButton;
    Image1: TImage;
    procedure Button2Click(Sender: TObject);
  private
    {Private declarations}
  public
    {Public declarations}
  end;

var
  Form1: TForm1;
  AChart: _Chart;
  mchart: ExcelChart;
  mshape: Shape;
  CellName: String;
  oChart: ExcelChart;
  Col: Char;
  defaultLCID: Cardinal;
  Row: Integer;
  mAxis:Axis;
  GridPrevFile: string;
  MyDisp: IDispatch;
  ExcelApp: ExcelApplication;
  v:variant;
  Sheet: ExcelWorksheet;
  y1, y2, y3, x, xb, xe, a1, a2, a3, st: Extended;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
  ExcelApp := CreateOleObject('Excel.Application') as ExcelApplication;

  ExcelApp.Visible[0] := True;

  ExcelApp.Workbooks.Add(xlWBatWorkSheet, 0);

  Sheet := ExcelApp.Workbooks[1].WorkSheets[1] as ExcelWorksheet;

  ExcelApp.Application.ReferenceStyle[0] := xlA1;

  xb:=StrToFloat(Edit1.Text);
  xe:=StrToFloat(Edit2.Text);
  st:=StrToFloat(Edit6.Text);



  col:='A';
  x:=xb;
  Sheet.Range[col+'1', col+'1'].Value[xlRangeValueDefault]:='X';
  row:=2;
  while ((x<=xe) and (x>=xb)) do
    begin
      Sheet.Range[col+IntToStr(row), col+IntToStr(row)].Value[xlRangeValueDefault]:=x;
      x:=x+st;
      row:=row+1;
    end;

  col:='B';
  x:=xb;
  Sheet.Range[col+'1', col+'1'].Value[xlRangeValueDefault]:='Y';
  row:=2;
  while (x<=0) and (x>=xb) and (X<=xe) do
    begin
      y1:=((3+4*cos(2*x)+cos(4*x))/8)+((1-cos(2*x))/2);
      Sheet.Range[col+IntToStr(row), col+IntToStr(row)].Value[xlRangeValueDefault]:=y1;
      x:=x+st;
      row:=row+1;
    end;
  while (x>=1) and (x>=xb) and (X<=xe) do
    begin
      y1:=((1-cos(2*x))/2);
      Sheet.Range[col+IntToStr(row), col+IntToStr(row)].Value[xlRangeValueDefault]:=y1;
      x:=x+st;
      row:=row+1;
    end;
  while (x>=xb) and (X<=xe) and not (x>=1) and not (x<=0) do
    begin
      y1:=1;
      Sheet.Range[col+IntToStr(row), col+IntToStr(row)].Value[xlRangeValueDefault]:=y1;
      x:=x+st;
      row:=row+1;
    end;

sheet.Range['A2','B'+inttostr(row)].Select;
mshape:=Sheet.Shapes.AddChart(xlXYScatterSmoothNoMarkers,250,1,800,800);
mchart:=(mshape.Chart as ExcelChart).Location(xlLocationAsNewSheet,EmptyParam);
ExcelApp.Application.ActiveWorkbook.ActiveChart.SetElement(1);
ExcelApp.Application.ActiveWorkbook.ActiveChart.ChartTitle[0].Text:='������ �������';
MyDisp:=mchart.Axes(xlValue, xlPrimary, 0);

   mAxis:=Axis(MyDisp);

    mAxis.HasTitle:=True;
    mAxis.AxisTitle.Caption:='X';

MyDisp:=mchart.Axes(xlCategory, xlPrimary, 0);

   mAxis:=Axis(MyDisp);

    mAxis.HasTitle:=True;
    mAxis.AxisTitle.Caption:='Y';

ExcelApp.Application.ActiveWorkbook.ActiveChart.SetElement(328);
mchart.HasLegend[0] := False;
sheet.name := '������';
mchart.name := '������ �������';

  end;

  end.
