unit mainTM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  PairSplitter, Grids, StdCtrls,lists;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure Edit3EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    //procedure einstellungenLesenUndSetzen();
    procedure moveForward();
    procedure initBand();
    procedure prepareBand();
    procedure moveBackward();
    procedure prepareStringGrid();
    procedure handleMove();
    function loadTM(FileName:String):Boolean;
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private

  public
    var
  hasMoved:Boolean;
   Band:TListOfPanel;
   zeiger,k:Integer;
   temp,currentZ:Integer;
   hasErw:Boolean;
   bandContent:TListOfString;
   leerzeichen:Char;
   MaschineAl:TListofString;
   Zustand2:TListOfInt;
   animation:Boolean;
   delay:Integer;
  end;

var
  Form1: TForm1;
  i:Integer;
  finished:Boolean;
  schritte:Integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
   //einstellungenLesenUndSetzen
   finished:=true;
   hasMoved:=true;
   currentZ:=1;
   bandContent:=TListOfString.Create;
   Band:=TListOfPanel.Create;
   MaschineAl:=TListOfString.Create;
   Self.DoubleBuffered:=true;
   leerzeichen:='#';
   zeiger := 5;
   for i:=1 to 13 do
   begin
     Band.Add(TPanel(Form1.FindComponent('Panel'+i.toString)));
     Band.getItem(i-1).DoubleBuffered:=true;
     bandContent.Add(leerzeichen);
   end;
   Zustand2:=TListOFInt.Create;
   Zustand2.Add(1);
end;

procedure TForm1.Edit3EditingDone(Sender: TObject);
Var changed2:boolean;
  prev:Char;
begin
  prev:=leerzeichen;
  if leerzeichen = Edit3.Text[1] then changed2:=false
  else changed2:=true;
  leerzeichen:=Edit3.TExt[1];
  if changed2 then
  begin
    for i:=0 to bandContent.Count-1 do
    begin
      if bandContent.getItem(i) = prev then bandContent.replaceItem(i,leerzeichen);
    end;
    initBand;
  end;
  Form1.StringGrid1.Cells[1,0]:=leerzeichen;
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
     Edit1.Text:=AnsiUpperCase(Edit1.Text);
     PrepareStringGrid;
end;

procedure TForm1.Edit2EditingDone(Sender: TObject);
begin
    Edit2.Text:=AnsiUpperCase(Edit2.Text);
    prepareBand();
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
begin

end;

procedure TForm1.moveForward();
begin

end;

procedure TForm1.initBand();
begin
   for i:=0 to band.Count()-1 do
   begin
      //ShowMessage(bandContent.getItem(i));
      if i >= zeiger then
      Band.getItem(i).Caption:=bandContent.getItem(i)
      else Band.getItem(i).Caption:=leerzeichen;
   end;
end;

procedure TForm1.prepareBand();
Var t:String;
  j:Integer;
  isInvalid:Boolean=false;
begin
   t:=Edit1.Text;
   isInvalid:=false;
   for i:=1 to Length(Edit2.Text) do
   begin
     if t.Contains(Edit2.Text[i]) then
     begin
       Label2.Caption:='';





      end
     else
     begin
       Label2.Caption:='Ungültige Eingabe';
       Edit2.Clear;
       isInvalid:=true;

end;
end;
     if not isInvalid then
     begin
   for j:=0 to Length(Edit2.Text)-1 do
       begin
          if j+zeiger-1<bandContent.Count-1 then
          begin
            //ShowMessage('Replace ' + Edit2.Text[j+1]);
            bandContent.replaceItem(j+6,Edit2.Text[j+1]);
          end
          else
          begin
             bandContent.add(Edit2.Text[j+1]);
            // ShowMessage('Add ' + Edit2.Text[j+1]);
          end;
       end;
       initBand();
       prepareStringGrid();
   end;

end;

procedure TForm1.moveBackward();
begin

end;


procedure TForm1.handleMove();
begin

end;

function TForm1.loadTM(FileName: String): Boolean;
begin

end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  Zustand2.add(Zustand2.Count+1);
  with StringGrid1 do
begin
   RowCount:=RowCount+1;
   Cells[0,RowCount-1]:='Z'+Zustand2.getItem(Zustand2.Count-1).toString;
   end;

end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  if StringGrid1.RowCount > 2 then
  begin
  Zustand2.deleteItemAt(Zustand2.Count-1);
  with StringGrid1 do
   RowCount:=RowCount-1;
 end;

end;

procedure TForm1.prepareStringGrid();
Var rawA:String;
  Col:Integer;
  j:Integer;
  isIn:Boolean;
begin
   rawA:=Edit1.Text;
   Zustand2.Clear;
   Zustand2.Add(1);

   for i:=1 to Length(rawA) do
   begin
      if not 'ABCDEFGHIJKLMNOPQRSTUVWXYZ+-/'.Contains(rawA[i]) then
      begin
        Delete(rawA,i,1);
      end;
   end;


   isIn:=false;
   StringGrid1.ColCount:=2;
   StringGrid1.Cells[1,0]:=leerzeichen;
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
   {if (Length(EditButton2.Text)<>0) and (EditButton2.Text <> ',') and (EditButton2.Text <> '') then
   begin
     for i:=1 to Length(EditButton2.Text) do
     begin
       if EditButton2.text[i] <> ',' then
       begin
          for Col:=1 to StringGrid1.ColCount-1 do
          begin
            if EditButton2.Text[i] = StringGrid1.Cells[Col,0] then
            begin
              isIn:=true;
            end;
          end;
          if not isIn then
          begin
            StringGrid1.ColCount:=StringGrid1.ColCount+1;
            StringGrid1.Cells[Col+1,0]:=EditButton2.Text[i];
            Inc(Col);
          end;
          isIn:=false;
       end
       else if EditButton2.Text[i] = ',' then
       begin
         //Do Nothing
       end
       else
       begin
         //Do Nothing
       end;
     end;
   end;                                    }
   StringGrid1.RowCount:=Zustand2.Count+1;
   for i:=1 to StringGrid1.RowCount-1 do
   begin
     StringGrid1.Cells[0,i]:='Z'+Zustand2.getItem(i-1).toString;
   end;


end;



end.

