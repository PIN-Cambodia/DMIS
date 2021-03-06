import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { NgAggregatePipesModule } from 'angular-pipes';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { AuthGuardService } from './shared/auth-guard.service';
import { AuthenticationService } from './shared/authentication.service';

import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import { MapComponent } from './map/map.component';
import { HomeComponent } from './home/home.component';
import { SitrepComponent } from './map/sitrep.component';
import { FaqComponent } from './faq/faq.component';
import { WeatherComponent } from './weather/weather.component';

import { RequestOptions } from '@angular/http';
import { RequestOptionsService } from './shared/request-options.service';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    MapComponent,
    HomeComponent,
    SitrepComponent,
    FaqComponent,
    WeatherComponent
  ],
  imports: [
      NgAggregatePipesModule,
      BrowserModule,
      FormsModule,
      HttpModule,
      BrowserAnimationsModule,
      RouterModule.forRoot([
          {
              path: '',
              component: HomeComponent
          },
          {
              path: 'login',
              component: LoginComponent
          },
          {
              path: 'map/:category',
              component: MapComponent,
              canActivate: [AuthGuardService]
          },
          {
              path: 'faq',
              component: FaqComponent
          },
          {
              path: 'weather',
              component: WeatherComponent
          },
          {
              path: 'sitrep',
              component: SitrepComponent
          },
          {
              path: 'admin',
              canActivate: [AuthGuardService],
              loadChildren: 'app/admin/admin.module#AdminModule'
          }
      ])
  ],
  providers: [AuthenticationService, AuthGuardService, {
    provide: RequestOptions, useClass: RequestOptionsService
  }],
  bootstrap: [AppComponent]
})
export class AppModule { }
