unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, ComCtrls, PairSplitter, Math, Lists, inputDialog;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    Timer2: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ControlBar1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1ChangeBounds(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure Timer2StartTimer(Sender: TObject);
    procedure Timer2StopTimer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure MoveForward();
    procedure MoveBackward();
    procedure Timer1Timer(Sender: TObject);
    procedure addPanelResize();
    procedure addPanel();
    procedure insertPanel();
    procedure removePanel();
    procedure FillPanelsWithContent();
    procedure handleMove();
    procedure setMode(mode:Integer);
    procedure prepareStringGrid();
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  band: TListofPanel;
  bandContent: TListofChar;
  i, pointer: integer;
  input: TForm2;
  Zustand2:Array of Integer;
  currentZ:Integer=1;
  finished:Boolean=true;
  hasMoved:Boolean=true;
  lastRawA:String;
  tempLeftValue:Integer;
implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.FormShow(Sender: TObject);
var
  ttPanel: TPanel;
  ttImage: TImage;
begin
  while (Form1.Width / 50) > band.Count() do
  begin
    ttPanel := TPanel.Create(Form1);
    ttPanel.Parent := Form1;
    ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
    ttPanel.Anchors := ttPanel.Anchors - [akTop];
    ttPanel.Top := Toolbar1.Height+PairSplitter1.Height+50;
    ttPanel.Height := 50;
    ttPanel.Width := 50;
    ttPanel.Left := band.Count() * 50;
    ttPanel.Caption := '#';


    band.Add(ttPanel);
    bandContent.Add('#');
  end;
  // add for animation
    ttPanel := TPanel.Create(Form1);
    ttPanel.Parent := Form1;
    ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
    ttPanel.Anchors := ttPanel.Anchors - [akTop];
    ttPanel.Top := Toolbar1.Height+PairSplitter1.Height+50;
    ttPanel.Height := 50;
    ttPanel.Width := 50;
    ttPanel.Left := band.Count() * 50;
    ttPanel.Caption := '#';


    band.Add(ttPanel);
    bandContent.Add('#');


    ttPanel := TPanel.Create(Form1);
    ttPanel.Parent := Form1;
    ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
    ttPanel.Anchors := ttPanel.Anchors - [akTop];
    ttPanel.Top := Toolbar1.Height+PairSplitter1.Height+50;
    ttPanel.Height := 50;
    ttPanel.Width := 50;
    ttPanel.Left := -50;
    ttPanel.Caption := '#';


    band.insertItem(ttPanel,0);
    bandContent.insertItem('#',0);


  //band.getItem(((band.Count - 1) div 2) - 1).Color := clDefault;
  pointer := ((band.Count{-1}) div 2);
   Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;


  // band.getItem((band.Count - 1) div 2).Color := Graphics.clHighlight;
  StatusBar1.Panels.Items[0].Text:='band Count: ' + band.Count.toString + '         bandContent Count: ' + bandContent.Count.toString;
  setMode(0);
end;

procedure TForm1.StringGrid1ChangeBounds(Sender: TObject);
begin
  Refresh();
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
Var wohin:Char;
begin
   if (StringGrid1.Col<>0) and (StringGrid1.Row<>0) then
   begin
     if Form2.Execute then
     begin
       if Form2.EndZustand then
       begin
         StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:='~Ende~';
       end else
       begin
         case Form2.WhereToGo of
         -1:Wohin:='L';
         0:Wohin:='0';
         1:Wohin:='R';
         end;
         StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:=Wohin+';'+Form2.WhatToWrite+';Z'+Form2.Zustand.toString;
       end;
     end;
   end;

end;

procedure TForm1.TabControl1Change(Sender: TObject);
begin

end;

procedure TForm1.Timer2StartTimer(Sender: TObject);
begin
  //tempLeftValue:=band.getItem(0).Left;
end;

procedure TForm1.Timer2StopTimer(Sender: TObject);
Var ttPanel:TPanel;
begin
  band.getItem(0).Destroy;
    band.deleteItemAt(0);
      ttPanel := TPanel.Create(Form1);
    ttPanel.Parent := Form1;
    ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
    ttPanel.Anchors := ttPanel.Anchors - [akTop];
    ttPanel.Top := Toolbar1.Height+PairSplitter1.Height+50;
    ttPanel.Height := 50;
    ttPanel.Width := 50;
    ttPanel.Left := band.getItem(band.Count-1).Left+50;
    ttPanel.Caption := '#';


    band.Add(ttPanel);
    bandContent.Add('#');


end;

procedure TForm1.Timer2Timer(Sender: TObject);
Var tempP: TPanel;
begin
  { if true then   //Wenn Animation aktiviert
   begin
      for i := 0 to Band.Count -1 do
      begin
        Band.getItem(i).Left :=Band.getItem(i).Left - 1;

      end;
   end else           //Wenn Animation deaktiviert
   begin
      for i := 0 to Band.Count - 1 do
      begin
        Band.getItem(i).Left := Band.getItem(i).Left - 50;
      end;
   end;

   if Band.getItem(0).Left = temp - 50 then
   begin
     if bandContent.count-1 >= (zeiger + (band.count div 2) then //zeiger + ?????
     begin
       band.getItem(0).Caption:=bandContent.getItem(zeiger+(band.count div 2)); //same
     end
     else
     begin
       band.getItem(0).Caption:='#';
       bandContent.addItem('#');
     end;
     hasMoved:=true;
     timer1.Enabled := false;
     }
     for i:=0 to band.Count-1 do
     begin
      band.getItem(i).Left:=band.getItem(i).Left-1;
     end;
     if band.getItem(1).Left=-50 then Timer2.Enabled:=false;
end;

procedure TForm1.MoveForward();
begin
 {   Inc(pointer);
  if pointer + (band.Count() - 1 div 2) > bandContent.Count then
  begin
    bandContent.Add('#');
    bandContent.insertItem('#', 0);
    Inc(Pointer);
    // Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;
  end;
  FillPanelsWithContent();    }


end;

procedure TForm1.MoveBackward();
begin
      Dec(pointer);
  if pointer - (band.Count() div 2) < 0 then
  begin
    bandContent.Add('#');
    bandContent.insertItem('#', 0);
    Inc(Pointer);
   //  Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;
  end;
  FillPanelsWithContent();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  handleMove();
  StatusBar1.Panels.Items[0].Text:='band Count: ' + band.Count.toString + '         bandContent Count: ' + bandContent.Count.toString;
end;







procedure TForm1.addPanelResize();
var
  ttPanel: TPanel;
begin
  if band.Count <> 0 then
  begin
  ttPanel := TPanel.Create(Form1);
  ttPanel.Parent := Form1;
  ttPanel.Top := 296 - StatusBar1.Height;
  ttPanel.Height := 50;
  ttPanel.Width := 50;
  ttPanel.Caption := '#';
  ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
  ttPanel.Anchors := ttPanel.Anchors - [akTop];

  if (frac(band.Count() / 2) = 0) then
  begin
    for i := 0 to band.Count - 1 do
    begin
      band.getItem(i).Left := band.getItem(i).Left + 50;
    end;
    if (pointer - (band.Count() div 2)) >= 0 then
    begin

      ttPanel.Caption := bandContent.getItem(pointer - (band.Count() div 2));

    end;
    ttPanel.Left := 0;
    band.insertItem(ttPanel, 0);
      Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;

    if bandContent.Count < band.Count then
    begin
      bandContent.insertItem('#', 0);
      Inc(pointer);
       Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;
    end;
  end
  else
  begin

    ttPanel.Left := band.Count * 50;
    if pointer + (band.Count() div 2) < bandContent.Count then
    begin
      ttPanel.Caption := bandContent.getItem(pointer + (band.Count() div 2));

    end;
    band.Add(ttPanel);
     Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;
    if bandContent.Count < band.Count then
      bandContent.Add('#');
  end;

end;

end;

procedure TForm1.addPanel();
var
  ttPanel: TPanel;
begin

end;

procedure TForm1.insertPanel();
begin

end;

procedure TForm1.removePanel();
begin

end;

procedure TForm1.FillPanelsWithContent();
var
  j: integer;
begin
  if (frac(band.Count() / 2) = 0) then
  begin
    for i := 0 to band.Count() - 1 do
    begin
      if not (i + (pointer - (band.Count() div 2) + 1))>=bandContent.Count then
      begin
      band.getItem(i).Caption :=
        bandContent.getItem(i + (pointer - (band.Count() div 2) + 1));

      end

    end;
  end
  else
  begin
    for i := 0 to band.Count() - 1 do
    begin
      if not (i + (pointer - (band.Count() div 2)))<0 then
      begin
      band.getItem(i).Caption :=
        bandContent.getItem(i + (pointer - (band.Count() div 2)));
        end

  end;

end;
end;
procedure TForm1.handleMove();
Var read:Char;
  X,Y:Integer;
  writeS:String;
  GridRect:TGridRect;

begin
   read:=bandContent.getItem(pointer);
   for i:=1 to StringGrid1.ColCount-1 do
   begin
     if StringGrid1.Cells[i,0] = read then
     begin
       X:=i;
       break;
     end;
   end;

   for i:=1 to StringGrid1.RowCount-1 do
   begin
     if StrToInt(StringGrid1.Cells[0,i].Chars[1]) = currentZ then
     begin
       Y:=i;
       break;
     end;
   end;
   GridRect.Top:=Y;
   GridRect.Left:=X;
   GridRect.Right:=X;
   GridRect.Bottom:=Y;
   StringGrid1.Selection := GridRect;

   if not StringGrid1.Cells[X,Y].contains('~Ende~') then
   begin
     if StringGrid1.Cells[X,Y].Chars[0] = 'L' then moveBackward();
     if StringGrid1.Cells[X,Y].Chars[0] = 'R' then moveForward();
     writeS:=StringGrid1.Cells[X,Y].Chars[2];
     currentZ:=StrToInt(StringGrid1.Cells[X,Y].SubString(5));
     bandContent.replaceItem(pointer-1,writeS[1]);
     FillPanelsWithContent();
   end else
   begin
     Timer1.Enabled:=false;
     ShowMessage('Ende');
   end;
end;

procedure TForm1.setMode(mode: Integer);
begin
   case mode of
   0:begin //anfangsmodus
     Edit1.Enabled:=true;
     Edit2.Enabled:=false;
     StringGrid1.Enabled:=false;
     ToolButton1.Enabled:=false;
     Toolbutton3.Enabled:=false;
     Toolbutton4.Enabled:=false;
   end;
   1:begin //Alphabet eingegeben Modus
     Edit1.Enabled:=true;
     Edit2.Enabled:=true;
     StringGrid1.Enabled:=true;
     ToolButton1.Enabled:=true;
     Toolbutton3.Enabled:=true;
     Toolbutton4.Enabled:=true;
   end;
end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
  if Timer2.Enabled then Timer2.Enabled:=false else Timer2.Enabled:=true;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  //moveForward();
end;

procedure TForm1.ControlBar1Click(Sender: TObject);
begin

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit1EditingDone(Sender: TObject); //Alphabet wurde eingegeben
var
  j: integer;
  t:String;
begin
  if not lastRawA.Equals(Edit1.Text) then
  begin
   // if lastRawA.Equals('') then ShowMessage('Jo'); //Wenn erste eingabe
  lastRawA:= AnsiUpperCase(Edit1.Text);
  Edit1.Text := lastRawA;

  prepareStringGrid();
  if StringGrid1.ColCount > 2 then setMode(1);
  Label1.Caption:='Alphabet: {';
  for i:=2 to StringGrid1.ColCount-1 do
  begin
      Label1.Caption:=Label1.Caption+StringGrid1.Cells[i,0];
      if i <> StringGrid1.ColCount-1 then Label1.Caption:=Label1.Caption+', ' else Label1.Caption:=Label1.Caption+'}';
  end;

  end
  else
  begin
    //Wenn eingabe gleiche wie vorher
  end;
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2EditingDone(Sender: TObject);
var
  i: integer;
  t:String;
begin
   t:=Edit1.Text;
   Edit2.Text:=AnsiUpperCase(edit2.Text);
  for i := 1 to Length(Edit2.Text) do
  begin
    if t.Contains(Edit2.Text[i]) then
    begin
      Label2.Caption:='';
    if i + pointer - 1 >= bandContent.Count then
    begin
      bandContent.Add(Edit2.Text[i]);
      bandContent.insertItem('#', 0);
      Inc(pointer); //not sure about this
    end
    else
      bandContent.replaceItem(i + pointer - 1, Edit2.Text[i]);

       FillPanelsWithContent();

    end
    else
    begin
         Label2.Caption:='Ungültige Eingabe';
         Edit2.Clear;
    end;
end;

end;

procedure TForm1.FormChangeBounds(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  band := TListOfPanel.Create;
  bandContent := TListOfChar.Create;
  SetLength(Zustand2,1);
  Zustand2[0]:=1;

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if band.Count <> 0 then
  begin
    while (Form1.Width / 50) > band.Count() do

  begin
    addPanelResize();

  //  FillPanelsWithContent();
  end;
  while ((Form1.Width / 50) + 1) < band.Count() do
  begin
    if not (frac(band.Count() / 2) = 0) then
    begin
      for i := 0 to band.Count() - 1 do
      begin
        band.getItem(i).Left := band.getItem(i).Left - 50;
      end;
      band.getItem(0).Destroy;
       Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;

      band.deleteItemAt(0);
       Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;  ;
    end
    else
    begin
      band.getItem(band.Count() - 1).Destroy;

      band.deleteItemAt(band.Count - 1);
       Image1.BorderSpacing.Left:=band.getItem(((band.Count{-1}) div 2)).Left+12;
    end;
  end;
  end;

  StatusBar1.Panels.Items[0].Text:='band Count: ' + band.Count.toString + '         bandContent Count: ' + bandContent.Count.toString;
end;

procedure TForm1.prepareStringGrid();
Var rawA:String;
  Col:Integer;
  j:Integer;
  isIn:Boolean;

begin
   rawA:=Edit1.Text;
   for i:=1 to Length(rawA) do
   begin
     if not 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890?ß+-/'.Contains(rawA[i]) then
     begin
       Delete(rawA,i,1);
     end;
   end;

   SetLength(Zustand2,0);
    SetLength(Zustand2,Length(Zustand2)+1);
     Zustand2[Length(Zustand2)]:=1;
   isIn:=false;
   StringGrid1.ColCount:=2;
   StringGrid1.Cells[1,0]:='#';
   for j:=1 to Length(rawA) do    //Durchlaufe Eingabe
   begin
     isIn:=false;
        for Col:=1 to StringGrid1.ColCount-1 do   //Durchlaufe Cols
        begin
          if rawA[j] = StringGrid1.Cells[Col,0] then  //Wenn Char in Cols isIn True
          begin
            isIn:=true;
          end;
        end;
        if not isIn then                 //Wenn Char nicht in Col = Hinzufügen
        begin
          StringGrid1.ColCount:=StringGrid1.ColCount+1;
          StringGrid1.Cells[Col+1,0]:=rawA[j];
           Inc(Col);
           isIn:=false;
        end;
   end;
   isIn:=false;
   StringGrid1.RowCount:=Length(Zustand2)+1;
   for i:=1 to StringGrid1.RowCount-1 do
   begin
     StringGrid1.Cells[0,i]:='Z'+Zustand2[i].toString;
   end;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if ToolButton1.Down then Timer1.Enabled:=true else Timer1.Enabled:=false;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  SetLength(Zustand2,Length(Zustand2)+1);
  Zustand2[Length(Zustand2)-1]:=Length(Zustand2);
  with StringGrid1 do
  begin
    RowCount:=RowCount+1;
    Cells[0,RowCount-1]:='Z'+Zustand2[Length(Zustand2)-1].toString;
  end;
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  if Length(Zustand2)>1 then
  begin
    SetLength(Zustand2,Length(Zustand2)-1);
    with StringGrid1 do
    begin
      RowCount:=RowCount-1;
    end;
  end;
end;

end.
