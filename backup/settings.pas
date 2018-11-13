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
    DividerBevel1: TDividerBevel;
    GroupBox1: TGroupBox;
    IniFile: TIniPropStorage;
    Label1: TLabel;
    Label2: TLabel;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    SpinEdit1: TSpinEdit;
    ToggleBox1: TToggleBox;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox1Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
  uses tMaschine;
{$R *.lfm}

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin
   IniFile.WriteBoolean('animation',ToggleBox1.Checked);
   IniFile.WriteInteger('delay',SpinEdit1.Value);
   Form1.delay:=SpinEdit1.Value;
   Form1.animation:=Togglebox1.Checked;
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
begin
   if FileExists('settings.ini') then
  begin
    Form1.animation:=IniFile.ReadBoolean('animation',true);
     ToggleBox1.Checked:=Form1.animation;
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
    if TreeView1.Selected.Index <> -1 then
    begin
      with TreeView1.Selected do
      begin

        if Index = 0 then
        begin
          //1. EinstellungsSeite
          Groupbox1.Caption:=Text;
        end;
      end;
    end;
end;

end.

