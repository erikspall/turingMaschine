unit settings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DividerBevel, Forms, Controls, Graphics, Dialogs,
  StdCtrls, PairSplitter, ComCtrls, IniPropStorage, Spin;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ColorButton3: TColorButton;
    ColorButton4: TColorButton;
    ComboBox1: TComboBox;
    DividerBevel1: TDividerBevel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    IniFile: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    SpinEdit1: TSpinEdit;
    ToggleBox1: TToggleBox;
    TreeView1: TTreeView;
    procedure Button3Click(Sender: TObject);
    procedure showGroup(Group:Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox1Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
  uses tMaschine;
{$R *.lfm}

{ TForm3 }

procedure TForm3.showGroup(Group: Integer);
begin
  case Group of
  1:begin Groupbox1.show; GroupBox2.hide; GroupBox3.hide;end;
  2:begin Groupbox1.hide; Groupbox2.show;GroupBox3.hide; end;
  3:begin Groupbox1.hide; Groupbox2.hide;GroupBox3.show; end;
  end;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  IniFile.IniSection:='settings';
   IniFile.WriteBoolean('animation',ToggleBox1.Checked);
   IniFile.WriteInteger('delay',SpinEdit1.Value);
   Form1.delay:=SpinEdit1.Value;
   Form1.animation:=Togglebox1.Checked;
   IniFile.IniSection:='colors';
   Form1.Panel15.Color:=ColorButton1.ButtonColor;
   IniFile.WriteString('panel',ColorToString(ColorButton1.ButtonColor));
   Form1.PairSplitter1.Color:=ColorButton2.ButtonColor;
   IniFile.WriteString('kontrast',ColorToString(ColorButton2.ButtonColor));
   Form1.StringGrid1.Color:=ColorButton3.ButtonColor;
   IniFile.WriteString('tabelle',ColorToString(ColorButton3.ButtonColor));
    Form1.Color:=ColorButton4.ButtonColor;
   IniFile.WriteString('band',ColorToString(ColorButton4.ButtonColor));
   Form3.Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
   Form3.Close;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.FormShow(Sender: TObject);
Var tempAn:Boolean;
  tempDe:Integer;
  tempCo:String;
begin
   if FileExists('settings.ini') then
  begin
    { GroupBox1 Werte Laden }
      IniFile.IniSection:='settings';
    tempAn:=IniFile.ReadBoolean('animation',true);
     ToggleBox1.Checked:=tempAn;
     tempDe:=IniFile.ReadInteger('delay',15);
     SpinEdit1.Value:=tempDe;

     { GroupBox2 Werte Laden  }
     IniFile.IniSection:='colors';
     tempCo:=IniFile.ReadString('panel','$00FEE3DE');
     ColorButton1.ButtonColor:=StringToColor(tempCo);
     tempCo:=IniFile.ReadString('kontrast','$00DE8F65');
     ColorButton2.ButtonColor:=StringToColor(tempCo);
     tempCo:=IniFile.ReadString('tabelle','$00FEE3DE');
     ColorButton3.ButtonColor:=StringToColor(tempCo);
     tempCo:=IniFile.ReadString('band','$00FFF0EE');
     ColorButton4.ButtonColor:=StringToColor(tempCo);

  end;
end;

procedure TForm3.ToggleBox1Change(Sender: TObject);
begin
  with ToggleBox1 do
begin
  if Caption = 'Ja' then Caption:='Nein' else Caption:='Ja';
end;
   end;

procedure TForm3.ToggleBox1Click(Sender: TObject);
Var i:Integer;
begin

end;

procedure TForm3.TreeView1Click(Sender: TObject);
begin
  if TreeView1.Selected.Index <> -1 then
    begin
      with TreeView1.Selected do
      begin

        if Text = 'Turing-Maschine' then
        begin
          //1. EinstellungsSeite
          Groupbox1.Caption:=Text;
          showGroup(1);
        end;

        if Text = 'Farben' then
        begin
          GroupBox2.Caption:=Text;
          showGroup(2);
        end;

        if Text = 'Sprachen' then
        begin
          GroupBox3.Caption:=Text;
          showGroup(3);
        end;
      end;
    end;
end;

end.

