

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';

import '../model/balance/balance_response.dart';
import '../model/banner/banner_response.dart';
import '../model/login/login_response.dart';
import '../model/profile/profile_response.dart';
import '../model/register/registration_response.dart';
import '../model/services/service_response.dart';
import '../model/transaction/transaction_history_response.dart';
import '../model/transaction/transaction_response.dart';

part 'rest_client.g.dart';

String baseUrl = dotenv.env['BASE_URL'].toString();
final String apiDomain = baseUrl;

@RestApi()
abstract class RestClient {
  factory RestClient({required Dio dio}) => _RestClient(dio);
  Dio get dio;

  @POST("registration")
  Future<RegistrationResponse> registration(
    @Field("email") String email,
    @Field("first_name") String firstName,
    @Field("last_name") String lastName,
    @Field("password") String password,
  );

  @POST("login")
  Future<LoginResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  @GET("profile")
  Future<ProfileResponse> getProfile();

  @PUT("profile/update")
  Future<ProfileResponse> updateProfile(
    @Field("first_name") String firstName,
    @Field("last_name") String lastName,
  );

  @MultiPart()
  @PUT("/profile/image")
  Future<ProfileResponse> updateProfileImage(@Body() dynamic _);

  @GET("banner")
  Future<BannerResponse> getBanner();

  @GET("services")
  Future<ServiceResponse> getServices();

  @GET("balance")
  Future<BalanceResponse> getBalance();

  @POST("topup")
  Future<BalanceResponse> topUp(@Field("top_up_amount") int topUpAmount);

  @POST("transaction")
  Future<TransactionResponse> transaction(
      @Field("service_code") String serviceCode,
      @Field("top_up_amount") int topUpAmount);

  @GET("transaction/history")
  Future<TransactionHistoryResponse> getTransactionHistory(
    @Query("offset") int offset,
    @Query("limit") int limit,
  );

}


