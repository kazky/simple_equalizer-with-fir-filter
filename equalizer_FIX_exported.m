classdef equalizer_FIX_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        EqualizerUIFigure  matlab.ui.Figure
        Panel              matlab.ui.container.Panel
        BrowseButton       matlab.ui.control.StateButton
        Label_2            matlab.ui.control.Label
        FileLabel          matlab.ui.control.Label
        UIAxes             matlab.ui.control.UIAxes
        UIAxes2            matlab.ui.control.UIAxes
        Panel_3            matlab.ui.container.Panel
        PopButton          matlab.ui.control.Button
        ReggaeButton       matlab.ui.control.Button
        RockButton         matlab.ui.control.Button
        TechnoButton       matlab.ui.control.Button
        PartyButton        matlab.ui.control.Button
        ClassicButton      matlab.ui.control.Button
        FlatButton         matlab.ui.control.Button
        EXTRMButton        matlab.ui.control.Button
        Panel_2            matlab.ui.container.Panel
        PLAYButton         matlab.ui.control.Button
        PAUSERESUMEButton  matlab.ui.control.Button
        STOPButton         matlab.ui.control.Button
        VOLUMESliderLabel  matlab.ui.control.Label
        VOLUMESlider       matlab.ui.control.Slider
        EditField          matlab.ui.control.NumericEditField
        RAWLabel           matlab.ui.control.Label
        FILTERLabel        matlab.ui.control.Label
        EQUALIZERLabel     matlab.ui.control.Label
        PRESETSLabel       matlab.ui.control.Label
        SETTINGSLabel      matlab.ui.control.Label
        Panel_4            matlab.ui.container.Panel
        HzLabel            matlab.ui.control.Label
        Slider             matlab.ui.control.Slider
        HzSlider_2Label    matlab.ui.control.Label
        Slider_2           matlab.ui.control.Slider
        HzSlider_3Label    matlab.ui.control.Label
        Slider_3           matlab.ui.control.Slider
        KHzSliderLabel     matlab.ui.control.Label
        Slider_4           matlab.ui.control.Slider
        Slider_5           matlab.ui.control.Slider
        Slider_6Label_2    matlab.ui.control.Label
        Slider_6           matlab.ui.control.Slider
        Slider_6Label_3    matlab.ui.control.Label
        KHzSlider_2Label   matlab.ui.control.Label
        Slider_7           matlab.ui.control.Slider
        KHzSlider_3Label   matlab.ui.control.Label
        Slider_8           matlab.ui.control.Slider
        KHzSlider_4Label   matlab.ui.control.Label
        Slider_9           matlab.ui.control.Slider
        KHzSlider_5Label   matlab.ui.control.Label
        Slider_10          matlab.ui.control.Slider
        SLIDERLabel        matlab.ui.control.Label
        Label_3            matlab.ui.control.Label
        Label_4            matlab.ui.control.Label
        Label_5            matlab.ui.control.Label
        Label_6            matlab.ui.control.Label
        Label_7            matlab.ui.control.Label
        Label_8            matlab.ui.control.Label
    end

    
   methods (Access = private)
        
        function play_equalizer(app)
            global sound;
            global pathname_text;
            global y_save
            global fs_save
            
            [x, fs] = audioread(pathname_text);
            Volume=app.VOLUMESlider.Value;
            %handles.y=handles.y(NewStart:end,:); 
            g1=app.Slider.Value;
            g2=app.Slider_2.Value;
            g3=app.Slider_3.Value;
            g4=app.Slider_5.Value;
            g5=app.Slider_6.Value;
            g6=app.Slider_6.Value;
            g7=app.Slider_7.Value;
            g8=app.Slider_8.Value;
            g9=app.Slider_9.Value;
            g10=app.Slider_10.Value;
          
            cut_off=200; %cut off low pass dalam Hz
            orde=16;
            a=fir1(orde,cut_off/(fs/2),'low');
            y1=g1*filter(a,1,x);
            
            % %bandpass1
            f1=201;
            f2=400;
            b1=fir1(orde,[f1/(fs/2) f2/(fs/2)],'bandpass');
            y2=g2*filter(b1,1,x);
            
            % %bandpass2
            f3=401;
            f4=800;
            b2=fir1(orde,[f3/(fs/2) f4/(fs/2)],'bandpass');
            y3=g3*filter(b2,1,x);
             
            % %bandpass3
            f4=801;
            f5=1500;
            b3=fir1(orde,[f4/(fs/2) f5/(fs/2)],'bandpass');
            y4=g4*filter(b3,1,x);
             
            % %bandpass4
            f5=1501;
            f6=3000;
            b4=fir1(orde,[f5/(fs/2) f6/(fs/2)],'bandpass');
            y5=g5*filter(b4,1,x);
             
            % %bandpass5
            f7=3001;
            f8=5000;
            b5=fir1(orde,[f7/(fs/2) f8/(fs/2)],'bandpass');
            y6=g6*filter(b5,1,x);
             
            % %bandpass6
            f9=5001;
            f10=7000;
            b6=fir1(orde,[f9/(fs/2) f10/(fs/2)],'bandpass');
            y7=g7*filter(b6,1,x);
             
            % %bandpass7
            f11=7001;
            f12=10000;
            b7=fir1(orde,[f11/(fs/2) f12/(fs/2)],'bandpass');
            y8=g8*filter(b7,1,x);
             
            % %bandpass8
            f13=10001;
            f14=15000;
            b8=fir1(orde,[f13/(fs/2) f14/(fs/2)],'bandpass');
            y9=g9*filter(b8,1,x);
             
            %highpass
            cut_off2=20000;
            c=fir1(orde,cut_off2/(fs/2),'high');
            y10=g10*filter(c,1,x);
            
            handles.yT=y1+y2+y3+y4+y5+y6+y7+y8+y9+y10;
            y_save=Volume*handles.yT;
            fs_save=fs;
            sound = audioplayer(y_save, fs_save);
            
            clc;
            
            ax2=app.UIAxes2;
            plot(ax2,y_save);
        end
   end
    

    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            global sound
            sound = 0;
        end

        % Callback function
        function VolumeKnobValueChanged(app, event)
            value = app.VolumeKnob.Value;
            app.EditField.Value=value;
        end

        % Callback function
        function VolumeKnobValueChanging(app, event)
            changingValue = event.Value;
            app.EditField.Value=changingValue;
        end

        % Value changed function: BrowseButton
        function BrowseButtonValueChanged(app, event)
            global sound
            global pathname_text
            global y_save
            global fs_save
            
            [filename, pathname] = uigetfile({'*.wav;*.flac;*.mp3','Supported audio file';... 
                                            '*.wav','Waveform Audio File Format (*.wav)';...
                                            '*.flac','Free Lossless Audio Codec (*.flac)';... 
                                            '*.mp3','MPEG 1 Layer3 (*.mp3)';...
                                            '*.*','All files (*.*)'});
                                        
            if isequal(filename,0) || isequal(pathname,0)
                sound = 0;
                return
            else
                [x, fs] = audioread([pathname,filename]);            % x:signal  fs:rate
                sound=audioplayer(x, fs);          
                pathname_text = strcat(pathname,filename);
                        
                app.Label_2.Text=pathname_text;
                
                ax=app.UIAxes;
                plot(ax,x);
                y_save=x;
                fs_save=fs;
            end
        end

        % Button pushed function: PopButton
        function PopButtonPushed(app, event)
            app.Slider.Value=-1.5;
            app.Slider_2.Value=3.9;
            app.Slider_3.Value=5.4;
            app.Slider_4.Value=4.5;
            app.Slider_5.Value=0.9;
            app.Slider_6.Value=-1.5;
            app.Slider_7.Value=-1.8;
            app.Slider_8.Value=-2.1;
            app.Slider_9.Value=-2.1;
            app.Slider_10.Value=-0.3;
        end

        % Button pushed function: TechnoButton
        function TechnoButtonPushed(app, event)
            app.Slider.Value=4.8;
            app.Slider_2.Value=4.2;
            app.Slider_3.Value=1.5;
            app.Slider_4.Value=-2.4;
            app.Slider_5.Value=-3.3;
            app.Slider_6.Value=-1.5;
            app.Slider_7.Value=1.5;
            app.Slider_8.Value=5.1;
            app.Slider_9.Value=5.7;
            app.Slider_10.Value=5.4;
        end

        % Button pushed function: ReggaeButton
        function ReggaeButtonPushed(app, event)
            app.Slider.Value=0;
            app.Slider_2.Value=0;
            app.Slider_3.Value=-0.3;
            app.Slider_4.Value=-2.7;
            app.Slider_5.Value=0;
            app.Slider_6.Value=2.1;
            app.Slider_7.Value=4.5;
            app.Slider_8.Value=3;
            app.Slider_9.Value=0.6;
            app.Slider_10.Value=0;
        end

        % Button pushed function: PartyButton
        function PartyButtonPushed(app, event)
            app.Slider.Value=5.4;
            app.Slider_2.Value=0;
            app.Slider_3.Value=0;
            app.Slider_4.Value=0;
            app.Slider_5.Value=0;
            app.Slider_6.Value=0;
            app.Slider_7.Value=0;
            app.Slider_8.Value=0;
            app.Slider_9.Value=0;
            app.Slider_10.Value=5.4;
        end

        % Button pushed function: RockButton
        function RockButtonPushed(app, event)
            app.Slider.Value=4.5;
            app.Slider_2.Value=-3.6;
            app.Slider_3.Value=-6.6;
            app.Slider_4.Value=-2.7;
            app.Slider_5.Value=2.1;
            app.Slider_6.Value=6;
            app.Slider_7.Value=7.5;
            app.Slider_8.Value=7.8;
            app.Slider_9.Value=7.8;
            app.Slider_10.Value=8.1;
        end

        % Button pushed function: ClassicButton
        function ClassicButtonPushed(app, event)
            app.Slider.Value=0;
            app.Slider_2.Value=0;
            app.Slider_3.Value=0;
            app.Slider_4.Value=0;
            app.Slider_5.Value=0;
            app.Slider_6.Value=0;
            app.Slider_7.Value=-0.3;
            app.Slider_8.Value=-5.7;
            app.Slider_9.Value=-6;
            app.Slider_10.Value=-8.1;
        end

        % Button pushed function: PLAYButton
        function PLAYButtonPushed(app, event)
            global sound 
            global M_S
            global PnS
            
            if sound == 0
                return
            else
                M_S = 1;
                PnS = 0;
                play_equalizer(app);
                playblocking(sound);
            end

        end

        % Button pushed function: PAUSERESUMEButton
        function PAUSERESUMEButtonPushed(app, event)
            global sound
            global M_S
            global PnS
            
            if M_S == 1
                if PnS == 0
                    PnS=1;
                    pause(sound);
                else
                    PnS=0;
                    resume(sound);
                end
            else
                return;
            end
            
        end

        % Button pushed function: STOPButton
        function STOPButtonPushed(app, event)
            global sound
            global M_S
            global PnS
            
            M_S = 0;
            PnS = 0;
            
            stop(sound);
            
        end

        % Button pushed function: FlatButton
        function FlatButtonPushed(app, event)
            app.Slider.Value=0.5;
            app.Slider_2.Value=0.5;
            app.Slider_3.Value=0.5;
            app.Slider_4.Value=0.5;
            app.Slider_5.Value=0.5;
            app.Slider_6.Value=0.5;
            app.Slider_7.Value=0.5;
            app.Slider_8.Value=0.5;
            app.Slider_9.Value=0.5;
            app.Slider_10.Value=0.5;
        end

        % Value changed function: VOLUMESlider
        function VOLUMESliderValueChanged(app, event)
            value = app.VOLUMESlider.Value;
            app.EditField.Value=value;
        end

        % Value changing function: VOLUMESlider
        function VOLUMESliderValueChanging(app, event)
            changingValue = event.Value;
            app.EditField.Value=changingValue;
        end

        % Button pushed function: EXTRMButton
        function EXTRMButtonPushed(app, event)
            app.Slider.Value=-20;
            app.Slider_2.Value=15;
            app.Slider_3.Value=15;
            app.Slider_4.Value=15;
            app.Slider_5.Value=15;
            app.Slider_6.Value=15;
            app.Slider_7.Value=15;
            app.Slider_8.Value=15;
            app.Slider_9.Value=15;
            app.Slider_10.Value=20;
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create EqualizerUIFigure
            app.EqualizerUIFigure = uifigure;
            app.EqualizerUIFigure.Color = [0.149 0.149 0.149];
            app.EqualizerUIFigure.Position = [100 100 1306 552];
            app.EqualizerUIFigure.Name = 'UI Figure';

            % Create Panel
            app.Panel = uipanel(app.EqualizerUIFigure);
            app.Panel.BackgroundColor = [0.2196 0.2588 0.3882];
            app.Panel.Position = [877 466 418 44];

            % Create BrowseButton
            app.BrowseButton = uibutton(app.Panel, 'state');
            app.BrowseButton.ValueChangedFcn = createCallbackFcn(app, @BrowseButtonValueChanged, true);
            app.BrowseButton.Text = 'Browse';
            app.BrowseButton.BackgroundColor = [0.302 0.749 0.9294];
            app.BrowseButton.FontWeight = 'bold';
            app.BrowseButton.FontAngle = 'italic';
            app.BrowseButton.FontColor = [1 1 1];
            app.BrowseButton.Position = [336 11 66 23];

            % Create Label_2
            app.Label_2 = uilabel(app.Panel);
            app.Label_2.BackgroundColor = [1 1 1];
            app.Label_2.FontName = 'Calibri';
            app.Label_2.Position = [45 13 278 19];
            app.Label_2.Text = '';

            % Create FileLabel
            app.FileLabel = uilabel(app.Panel);
            app.FileLabel.FontColor = [1 1 1];
            app.FileLabel.Position = [13 11 25 22];
            app.FileLabel.Text = 'File';

            % Create UIAxes
            app.UIAxes = uiaxes(app.EqualizerUIFigure);
            title(app.UIAxes, '')
            xlabel(app.UIAxes, '')
            ylabel(app.UIAxes, '')
            app.UIAxes.FontName = 'Calibri';
            app.UIAxes.GridColor = [0.851 0.851 0.851];
            app.UIAxes.MinorGridColor = [0.851 0.851 0.851];
            app.UIAxes.Box = 'on';
            app.UIAxes.XColor = [0.851 0.851 0.851];
            app.UIAxes.YColor = [0.851 0.851 0.851];
            app.UIAxes.ZColor = [0.851 0.851 0.851];
            app.UIAxes.Color = 'none';
            app.UIAxes.TitleFontWeight = 'normal';
            app.UIAxes.BackgroundColor = [0.3412 0.3882 0.4588];
            app.UIAxes.Position = [13 278 414 189];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.EqualizerUIFigure);
            title(app.UIAxes2, '')
            xlabel(app.UIAxes2, '')
            ylabel(app.UIAxes2, '')
            app.UIAxes2.FontName = 'Calibri';
            app.UIAxes2.GridColor = [0.851 0.851 0.851];
            app.UIAxes2.MinorGridColor = [0.851 0.851 0.851];
            app.UIAxes2.Box = 'on';
            app.UIAxes2.XColor = [0.851 0.851 0.851];
            app.UIAxes2.YColor = [0.851 0.851 0.851];
            app.UIAxes2.ZColor = [0.851 0.851 0.851];
            app.UIAxes2.Color = 'none';
            app.UIAxes2.TitleFontWeight = 'normal';
            app.UIAxes2.BackgroundColor = [0.3412 0.3882 0.4588];
            app.UIAxes2.Position = [446 278 404 189];

            % Create Panel_3
            app.Panel_3 = uipanel(app.EqualizerUIFigure);
            app.Panel_3.TitlePosition = 'centertop';
            app.Panel_3.BackgroundColor = [0.2157 0.2588 0.3882];
            app.Panel_3.Position = [671 24 176 224];

            % Create PopButton
            app.PopButton = uibutton(app.Panel_3, 'push');
            app.PopButton.ButtonPushedFcn = createCallbackFcn(app, @PopButtonPushed, true);
            app.PopButton.BackgroundColor = [1 1 1];
            app.PopButton.FontSize = 14;
            app.PopButton.FontWeight = 'bold';
            app.PopButton.FontColor = [0.149 0.149 0.149];
            app.PopButton.Position = [14 167 64 30];
            app.PopButton.Text = 'Pop';

            % Create ReggaeButton
            app.ReggaeButton = uibutton(app.Panel_3, 'push');
            app.ReggaeButton.ButtonPushedFcn = createCallbackFcn(app, @ReggaeButtonPushed, true);
            app.ReggaeButton.BackgroundColor = [1 1 1];
            app.ReggaeButton.FontSize = 14;
            app.ReggaeButton.FontWeight = 'bold';
            app.ReggaeButton.FontColor = [0.149 0.149 0.149];
            app.ReggaeButton.Position = [14 116 64 30];
            app.ReggaeButton.Text = 'Reggae';

            % Create RockButton
            app.RockButton = uibutton(app.Panel_3, 'push');
            app.RockButton.ButtonPushedFcn = createCallbackFcn(app, @RockButtonPushed, true);
            app.RockButton.BackgroundColor = [1 1 1];
            app.RockButton.FontSize = 14;
            app.RockButton.FontWeight = 'bold';
            app.RockButton.FontColor = [0.149 0.149 0.149];
            app.RockButton.Position = [14 66 64 30];
            app.RockButton.Text = 'Rock';

            % Create TechnoButton
            app.TechnoButton = uibutton(app.Panel_3, 'push');
            app.TechnoButton.ButtonPushedFcn = createCallbackFcn(app, @TechnoButtonPushed, true);
            app.TechnoButton.BackgroundColor = [1 1 1];
            app.TechnoButton.FontSize = 14;
            app.TechnoButton.FontWeight = 'bold';
            app.TechnoButton.FontColor = [0.149 0.149 0.149];
            app.TechnoButton.Position = [93 167 74 30];
            app.TechnoButton.Text = 'Techno';

            % Create PartyButton
            app.PartyButton = uibutton(app.Panel_3, 'push');
            app.PartyButton.ButtonPushedFcn = createCallbackFcn(app, @PartyButtonPushed, true);
            app.PartyButton.BackgroundColor = [1 1 1];
            app.PartyButton.FontSize = 14;
            app.PartyButton.FontWeight = 'bold';
            app.PartyButton.FontColor = [0.149 0.149 0.149];
            app.PartyButton.Position = [93 116 74 30];
            app.PartyButton.Text = 'Party';

            % Create ClassicButton
            app.ClassicButton = uibutton(app.Panel_3, 'push');
            app.ClassicButton.ButtonPushedFcn = createCallbackFcn(app, @ClassicButtonPushed, true);
            app.ClassicButton.BackgroundColor = [1 1 1];
            app.ClassicButton.FontSize = 14;
            app.ClassicButton.FontWeight = 'bold';
            app.ClassicButton.FontColor = [0.149 0.149 0.149];
            app.ClassicButton.Position = [93 67 74 30];
            app.ClassicButton.Text = 'Classic';

            % Create FlatButton
            app.FlatButton = uibutton(app.Panel_3, 'push');
            app.FlatButton.ButtonPushedFcn = createCallbackFcn(app, @FlatButtonPushed, true);
            app.FlatButton.BackgroundColor = [1 1 1];
            app.FlatButton.FontSize = 14;
            app.FlatButton.FontWeight = 'bold';
            app.FlatButton.FontColor = [0.149 0.149 0.149];
            app.FlatButton.Position = [14 17 64 30];
            app.FlatButton.Text = 'Flat';

            % Create EXTRMButton
            app.EXTRMButton = uibutton(app.Panel_3, 'push');
            app.EXTRMButton.ButtonPushedFcn = createCallbackFcn(app, @EXTRMButtonPushed, true);
            app.EXTRMButton.BackgroundColor = [1 1 1];
            app.EXTRMButton.FontSize = 14;
            app.EXTRMButton.FontWeight = 'bold';
            app.EXTRMButton.FontColor = [0.149 0.149 0.149];
            app.EXTRMButton.Position = [92.5 17 74 30];
            app.EXTRMButton.Text = 'EXTRM';

            % Create Panel_2
            app.Panel_2 = uipanel(app.EqualizerUIFigure);
            app.Panel_2.ForegroundColor = [0.851 0.851 0.851];
            app.Panel_2.TitlePosition = 'centertop';
            app.Panel_2.BackgroundColor = [0.2196 0.2588 0.3882];
            app.Panel_2.FontName = 'Calibri';
            app.Panel_2.FontSize = 18;
            app.Panel_2.Position = [870 88 425 332];

            % Create PLAYButton
            app.PLAYButton = uibutton(app.Panel_2, 'push');
            app.PLAYButton.ButtonPushedFcn = createCallbackFcn(app, @PLAYButtonPushed, true);
            app.PLAYButton.BackgroundColor = [1 1 1];
            app.PLAYButton.FontSize = 14;
            app.PLAYButton.FontWeight = 'bold';
            app.PLAYButton.Position = [139 259 148 50];
            app.PLAYButton.Text = 'PLAY';

            % Create PAUSERESUMEButton
            app.PAUSERESUMEButton = uibutton(app.Panel_2, 'push');
            app.PAUSERESUMEButton.ButtonPushedFcn = createCallbackFcn(app, @PAUSERESUMEButtonPushed, true);
            app.PAUSERESUMEButton.BackgroundColor = [1 1 1];
            app.PAUSERESUMEButton.FontSize = 14;
            app.PAUSERESUMEButton.FontWeight = 'bold';
            app.PAUSERESUMEButton.Position = [139 199 148 50];
            app.PAUSERESUMEButton.Text = 'PAUSE/RESUME';

            % Create STOPButton
            app.STOPButton = uibutton(app.Panel_2, 'push');
            app.STOPButton.ButtonPushedFcn = createCallbackFcn(app, @STOPButtonPushed, true);
            app.STOPButton.BackgroundColor = [1 1 1];
            app.STOPButton.FontSize = 14;
            app.STOPButton.FontWeight = 'bold';
            app.STOPButton.Position = [139 139 148 50];
            app.STOPButton.Text = 'STOP';

            % Create VOLUMESliderLabel
            app.VOLUMESliderLabel = uilabel(app.Panel_2);
            app.VOLUMESliderLabel.BackgroundColor = [0.4706 0.5216 0.7098];
            app.VOLUMESliderLabel.HorizontalAlignment = 'center';
            app.VOLUMESliderLabel.FontWeight = 'bold';
            app.VOLUMESliderLabel.FontAngle = 'italic';
            app.VOLUMESliderLabel.FontColor = [1 1 1];
            app.VOLUMESliderLabel.Position = [171 53 82 24];
            app.VOLUMESliderLabel.Text = 'VOLUME';

            % Create VOLUMESlider
            app.VOLUMESlider = uislider(app.Panel_2);
            app.VOLUMESlider.Limits = [0 1];
            app.VOLUMESlider.ValueChangedFcn = createCallbackFcn(app, @VOLUMESliderValueChanged, true);
            app.VOLUMESlider.ValueChangingFcn = createCallbackFcn(app, @VOLUMESliderValueChanging, true);
            app.VOLUMESlider.FontColor = [1 1 1];
            app.VOLUMESlider.Position = [38 111 350 3];
            app.VOLUMESlider.Value = 0.3;

            % Create EditField
            app.EditField = uieditfield(app.Panel_2, 'numeric');
            app.EditField.HorizontalAlignment = 'center';
            app.EditField.Position = [181 27 64 22];
            app.EditField.Value = 0.3;

            % Create RAWLabel
            app.RAWLabel = uilabel(app.EqualizerUIFigure);
            app.RAWLabel.BackgroundColor = [0.4706 0.5216 0.7098];
            app.RAWLabel.HorizontalAlignment = 'center';
            app.RAWLabel.FontColor = [1 1 1];
            app.RAWLabel.Position = [279 466 115 22];
            app.RAWLabel.Text = 'RAW';

            % Create FILTERLabel
            app.FILTERLabel = uilabel(app.EqualizerUIFigure);
            app.FILTERLabel.BackgroundColor = [0.4706 0.5216 0.7098];
            app.FILTERLabel.HorizontalAlignment = 'center';
            app.FILTERLabel.FontColor = [1 1 1];
            app.FILTERLabel.Position = [712 466 115 22];
            app.FILTERLabel.Text = 'FILTER';

            % Create EQUALIZERLabel
            app.EQUALIZERLabel = uilabel(app.EqualizerUIFigure);
            app.EQUALIZERLabel.BackgroundColor = [1 1 1];
            app.EQUALIZERLabel.HorizontalAlignment = 'center';
            app.EQUALIZERLabel.FontSize = 36;
            app.EQUALIZERLabel.FontWeight = 'bold';
            app.EQUALIZERLabel.FontAngle = 'italic';
            app.EQUALIZERLabel.FontColor = [0.4902 0.1804 0.5608];
            app.EQUALIZERLabel.Position = [13 495 225 46];
            app.EQUALIZERLabel.Text = 'EQUALIZER ';

            % Create PRESETSLabel
            app.PRESETSLabel = uilabel(app.EqualizerUIFigure);
            app.PRESETSLabel.BackgroundColor = [0.4706 0.5216 0.7098];
            app.PRESETSLabel.HorizontalAlignment = 'center';
            app.PRESETSLabel.FontColor = [1 1 1];
            app.PRESETSLabel.Position = [763 243 76 22];
            app.PRESETSLabel.Text = 'PRESETS';

            % Create SETTINGSLabel
            app.SETTINGSLabel = uilabel(app.EqualizerUIFigure);
            app.SETTINGSLabel.BackgroundColor = [0.4706 0.5216 0.7098];
            app.SETTINGSLabel.HorizontalAlignment = 'center';
            app.SETTINGSLabel.FontColor = [1 1 1];
            app.SETTINGSLabel.Position = [1175 411 112 22];
            app.SETTINGSLabel.Text = 'SETTINGS';

            % Create Panel_4
            app.Panel_4 = uipanel(app.EqualizerUIFigure);
            app.Panel_4.BackgroundColor = [0.2196 0.2588 0.3882];
            app.Panel_4.Position = [18 24 638 224];

            % Create HzLabel
            app.HzLabel = uilabel(app.Panel_4);
            app.HzLabel.HorizontalAlignment = 'right';
            app.HzLabel.FontColor = [1 1 1];
            app.HzLabel.Position = [17 19 43 22];
            app.HzLabel.Text = '200 Hz';

            % Create Slider
            app.Slider = uislider(app.Panel_4);
            app.Slider.Limits = [-20 20];
            app.Slider.Orientation = 'vertical';
            app.Slider.FontColor = [1 1 1];
            app.Slider.Position = [31 57 3 150];
            app.Slider.Value = 0.5;

            % Create HzSlider_2Label
            app.HzSlider_2Label = uilabel(app.Panel_4);
            app.HzSlider_2Label.HorizontalAlignment = 'right';
            app.HzSlider_2Label.FontColor = [1 1 1];
            app.HzSlider_2Label.Position = [71 19 43 22];
            app.HzSlider_2Label.Text = '400 Hz';

            % Create Slider_2
            app.Slider_2 = uislider(app.Panel_4);
            app.Slider_2.Limits = [-20 20];
            app.Slider_2.Orientation = 'vertical';
            app.Slider_2.FontColor = [1 1 1];
            app.Slider_2.Position = [91 57 3 150];
            app.Slider_2.Value = 0.5;

            % Create HzSlider_3Label
            app.HzSlider_3Label = uilabel(app.Panel_4);
            app.HzSlider_3Label.HorizontalAlignment = 'right';
            app.HzSlider_3Label.FontColor = [1 1 1];
            app.HzSlider_3Label.Position = [131 19 43 22];
            app.HzSlider_3Label.Text = '800 Hz';

            % Create Slider_3
            app.Slider_3 = uislider(app.Panel_4);
            app.Slider_3.Limits = [-20 20];
            app.Slider_3.Orientation = 'vertical';
            app.Slider_3.FontColor = [1 1 1];
            app.Slider_3.Position = [151 57 3 150];
            app.Slider_3.Value = 0.5;

            % Create KHzSliderLabel
            app.KHzSliderLabel = uilabel(app.Panel_4);
            app.KHzSliderLabel.HorizontalAlignment = 'right';
            app.KHzSliderLabel.FontColor = [1 1 1];
            app.KHzSliderLabel.Position = [191 19 48 22];
            app.KHzSliderLabel.Text = '1,5 KHz';

            % Create Slider_4
            app.Slider_4 = uislider(app.Panel_4);
            app.Slider_4.Limits = [-20 20];
            app.Slider_4.Orientation = 'vertical';
            app.Slider_4.FontColor = [1 1 1];
            app.Slider_4.Position = [213 57 3 150];
            app.Slider_4.Value = 0.5;

            % Create Slider_5
            app.Slider_5 = uislider(app.Panel_4);
            app.Slider_5.Limits = [-20 20];
            app.Slider_5.Orientation = 'vertical';
            app.Slider_5.FontColor = [1 1 1];
            app.Slider_5.Position = [273 57 3 150];
            app.Slider_5.Value = 0.5;

            % Create Slider_6Label_2
            app.Slider_6Label_2 = uilabel(app.Panel_4);
            app.Slider_6Label_2.HorizontalAlignment = 'right';
            app.Slider_6Label_2.FontColor = [1 1 1];
            app.Slider_6Label_2.Position = [256 19 38 22];
            app.Slider_6Label_2.Text = '3 KHz';

            % Create Slider_6
            app.Slider_6 = uislider(app.Panel_4);
            app.Slider_6.Limits = [-20 20];
            app.Slider_6.Orientation = 'vertical';
            app.Slider_6.FontColor = [1 1 1];
            app.Slider_6.Position = [333 57 3 150];
            app.Slider_6.Value = 0.5;

            % Create Slider_6Label_3
            app.Slider_6Label_3 = uilabel(app.Panel_4);
            app.Slider_6Label_3.HorizontalAlignment = 'right';
            app.Slider_6Label_3.FontColor = [1 1 1];
            app.Slider_6Label_3.Position = [316 19 38 22];
            app.Slider_6Label_3.Text = '5 KHz';

            % Create KHzSlider_2Label
            app.KHzSlider_2Label = uilabel(app.Panel_4);
            app.KHzSlider_2Label.HorizontalAlignment = 'right';
            app.KHzSlider_2Label.FontColor = [1 1 1];
            app.KHzSlider_2Label.Position = [371 19 38 22];
            app.KHzSlider_2Label.Text = '7 KHz';

            % Create Slider_7
            app.Slider_7 = uislider(app.Panel_4);
            app.Slider_7.Limits = [-20 20];
            app.Slider_7.Orientation = 'vertical';
            app.Slider_7.FontColor = [1 1 1];
            app.Slider_7.Position = [388 57 3 150];
            app.Slider_7.Value = 0.5;

            % Create KHzSlider_3Label
            app.KHzSlider_3Label = uilabel(app.Panel_4);
            app.KHzSlider_3Label.HorizontalAlignment = 'right';
            app.KHzSlider_3Label.FontColor = [1 1 1];
            app.KHzSlider_3Label.Position = [428 19 45 22];
            app.KHzSlider_3Label.Text = '10 KHz';

            % Create Slider_8
            app.Slider_8 = uislider(app.Panel_4);
            app.Slider_8.Limits = [-20 20];
            app.Slider_8.Orientation = 'vertical';
            app.Slider_8.FontColor = [1 1 1];
            app.Slider_8.Position = [449 57 3 150];
            app.Slider_8.Value = 0.5;

            % Create KHzSlider_4Label
            app.KHzSlider_4Label = uilabel(app.Panel_4);
            app.KHzSlider_4Label.HorizontalAlignment = 'right';
            app.KHzSlider_4Label.FontColor = [1 1 1];
            app.KHzSlider_4Label.Position = [489 19 45 22];
            app.KHzSlider_4Label.Text = '15 KHz';

            % Create Slider_9
            app.Slider_9 = uislider(app.Panel_4);
            app.Slider_9.Limits = [-20 20];
            app.Slider_9.Orientation = 'vertical';
            app.Slider_9.FontColor = [1 1 1];
            app.Slider_9.Position = [510 57 3 150];
            app.Slider_9.Value = 0.5;

            % Create KHzSlider_5Label
            app.KHzSlider_5Label = uilabel(app.Panel_4);
            app.KHzSlider_5Label.HorizontalAlignment = 'right';
            app.KHzSlider_5Label.FontColor = [1 1 1];
            app.KHzSlider_5Label.Position = [550 19 45 22];
            app.KHzSlider_5Label.Text = '20 KHz';

            % Create Slider_10
            app.Slider_10 = uislider(app.Panel_4);
            app.Slider_10.Limits = [-20 20];
            app.Slider_10.Orientation = 'vertical';
            app.Slider_10.FontColor = [1 1 1];
            app.Slider_10.Position = [571 57 3 150];
            app.Slider_10.Value = 0.5;

            % Create SLIDERLabel
            app.SLIDERLabel = uilabel(app.EqualizerUIFigure);
            app.SLIDERLabel.BackgroundColor = [0.4745 0.5216 0.7098];
            app.SLIDERLabel.HorizontalAlignment = 'center';
            app.SLIDERLabel.FontColor = [1 1 1];
            app.SLIDERLabel.Position = [572 243 76 22];
            app.SLIDERLabel.Text = 'SLIDER';

            % Create Label_3
            app.Label_3 = uilabel(app.EqualizerUIFigure);
            app.Label_3.BackgroundColor = [1 1 1];
            app.Label_3.Position = [223 531 49 10];
            app.Label_3.Text = '';

            % Create Label_4
            app.Label_4 = uilabel(app.EqualizerUIFigure);
            app.Label_4.BackgroundColor = [1 1 1];
            app.Label_4.Position = [231 513 10 10];
            app.Label_4.Text = '';

            % Create Label_5
            app.Label_5 = uilabel(app.EqualizerUIFigure);
            app.Label_5.BackgroundColor = [1 1 1];
            app.Label_5.Position = [236 497 10 10];
            app.Label_5.Text = '';

            % Create Label_6
            app.Label_6 = uilabel(app.EqualizerUIFigure);
            app.Label_6.BackgroundColor = [1 1 1];
            app.Label_6.Position = [13 486 10 10];
            app.Label_6.Text = '';

            % Create Label_7
            app.Label_7 = uilabel(app.EqualizerUIFigure);
            app.Label_7.BackgroundColor = [1 1 1];
            app.Label_7.Position = [244 513 14 10];
            app.Label_7.Text = '';

            % Create Label_8
            app.Label_8 = uilabel(app.EqualizerUIFigure);
            app.Label_8.BackgroundColor = [1 1 1];
            app.Label_8.Position = [33 491 10 10];
            app.Label_8.Text = '';
        end
    end

    methods (Access = public)

        % Construct app
        function app = equalizer_FIX_exported

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.EqualizerUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.EqualizerUIFigure)
        end
    end
end