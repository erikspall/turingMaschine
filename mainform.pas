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
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
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
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ControlBar1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1ChangeBounds(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
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
    procedure prepareStringGrid();
  private

  public

  end;

var
  Form1: TForm1;
  band: TListofPanel;
  bandContent: TListofChar;
  i, pointer: integer;
  input: TForm2;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.FormShow(Sender: TObject);
var
  ttPanel: TPanel;
begin
  while (Form1.Width / 50) > band.Count() do
  begin
    ttPanel := TPanel.Create(Form1);
    ttPanel.Parent := Form1;
    ttPanel.AnchorParallel(akBottom, StatusBar1.Height, StatusBar1);
    ttPanel.Anchors := ttPanel.Anchors - [akTop];
    ttPanel.Top := 296 - StatusBar1.Height;
    ttPanel.Height := 50;
    ttPanel.Width := 50;
    ttPanel.Left := band.Count() * 50;
    ttPanel.Caption := '#';


    band.Add(ttPanel);
    bandContent.Add('#');
  end;

  band.getItem(((band.Count - 1) div 2) - 1).Color := clDefault;
  pointer := ((band.Count - 1) div 2);
  band.getItem((band.Count - 1) div 2).Color := Graphics.clHighlight;
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

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Dec(pointer);
  if pointer - (band.Count() div 2) < 0 then
  begin
    bandContent.Add('#');
    bandContent.insertItem('#', 0);
    Inc(Pointer);
  end;
  FillPanelsWithContent();
end;

procedure TForm1.MoveForward();
begin
    Inc(pointer);
  if pointer + (band.Count() - 1 div 2) > bandContent.Count then
  begin
    bandContent.Add('#');
    bandContent.insertItem('#', 0);
    Inc(Pointer);
  end;
  FillPanelsWithContent();
end;

procedure TForm1.MoveBackward();
begin
      Dec(pointer);
  if pointer - (band.Count() div 2) < 0 then
  begin
    bandContent.Add('#');
    bandContent.insertItem('#', 0);
    Inc(Pointer);
  end;
  FillPanelsWithContent();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  handleMove();
end;







procedure TForm1.addPanelResize();
var
  ttPanel: TPanel;
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
    if pointer - (band.Count() div 2) >= 0 then
      ttPanel.Caption := bandContent.getItem(pointer - (band.Count() div 2));
    ttPanel.Left := 0;
    band.insertItem(ttPanel, 0);

    Label1.Caption := pointer.toString;
    if bandContent.Count < band.Count then
    begin
      bandContent.insertItem('#', 0);
      Inc(pointer);
    end;
  end
  else
  begin

    ttPanel.Left := band.Count * 50;
    if pointer + (band.Count() div 2) < bandContent.Count then
      ttPanel.Caption := bandContent.getItem(pointer + (band.Count() div 2));
    band.Add(ttPanel);
    if bandContent.Count < band.Count then
      bandContent.Add('#');
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
      band.getItem(i).Caption :=
        bandContent.getItem(i + (pointer - (band.Count() div 2) + 1));
    end;
  end
  else
  begin
    for i := 0 to band.Count() - 1 do
    begin
      band.getItem(i).Caption :=
        bandContent.getItem(i + (pointer - (band.Count() div 2)));
    end;
  end;

end;

procedure TForm1.handleMove();
Var read:Char;
  X,Y:Integer;
  writeS:String;
  GridRect:TGridRect;
  currentZ:Integer=1;
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Timer1.Enabled then Timer1.Enabled:=false else Timer1.Enabled:=true;

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
  idk:boolean=false;
begin
 { Edit1.Text := AnsiUpperCase(Edit1.Text);
   t:=Edit1.Text;

   StringGrid1.ColCount:=2;

   for i:=1 to Length(t) do
   begin
     if not 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890?ß+-/'.Contains(t[i]) then
     begin
       Delete(t,i,1);
     end;
   end;

  for i:=1 to Length(t) do
  begin
    StringGrid1.ColCount:=StringGrid1.ColCount+1;
    StringGrid1.Cells[i+1,0]:=t[i];
  end;   }
  prepareStringGrid();

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
    end;
end;

end;

procedure TForm1.FormChangeBounds(Sender: TObject);
begin
  while (Form1.Width / 50) > band.Count() do
  begin
    addPanelResize();
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


      band.deleteItemAt(0);
    end
    else
    begin
      band.getItem(band.Count() - 1).Destroy;

      band.deleteItemAt(band.Count - 1);
    end;
  end;










  FillPanelsWithContent();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  band := TListOfPanel.Create;
  bandContent := TListOfChar.Create;

end;

procedure TForm1.prepareStringGrid();
Var rawA:String;
  Col:Integer;
  j:Integer;
  isIn:Boolean;
begin
   rawA:=Edit1.Text;
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
   if (Length(Edit2.Text)<>0) and (Edit2.Text <> ',') and (Edit2.Text <> '') then
   begin
     for i:=1 to Length(Edit2.Text) do
     begin
       if Edit2.text[i] <> ',' then
       begin
          for Col:=1 to StringGrid1.ColCount-1 do
          begin
            if Edit2.Text[i] = StringGrid1.Cells[Col,0] then
            begin
              isIn:=true;
            end;
          end;
          if not isIn then
          begin
            StringGrid1.ColCount:=StringGrid1.ColCount+1;
            StringGrid1.Cells[Col+1,0]:=Edit2.Text[i];
            Inc(Col);
          end;
          isIn:=false;
       end
       else if Edit2.Text[i] = ',' then
       begin
         //Do Nothing
       end
       else
       begin
         //Do Nothing
       end;
     end;
   end;
   StringGrid1.RowCount:=Length(Zustand2)+1;
   for i:=1 to StringGrid1.RowCount-1 do
   begin
     StringGrid1.Cells[0,i]:='Z'+Zustand2[i].toString;
   end;
end;
end.
